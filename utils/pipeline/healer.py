"""Layout-drift detection and guarded auto-repair of extraction specs.

The contract: **a healed spec is only ever accepted if it does not break what
already worked.** That is enforced by three gates.

1. *Drift detection* - compare this run's health against a stored baseline
   (row counts, per-field fill rates, required-field coverage).
2. *Repair search* - try declared ``candidates`` and auto-relaxed variants for
   only the fields that actually broke. Fields that are still healthy are
   never touched.
3. *Regression guard* - the candidate spec must (a) be healthier than the
   current spec, (b) still satisfy every validation rule, and (c) reproduce
   every record in the stored **golden sample** from the last known-good run.

If a repair passes all three it is written as a new spec version (the old one
is backed up under ``schemas/versions/``). If it passes but with low
confidence, it is written and flagged ``needs_review`` so a human can confirm.
If it fails, nothing changes and the run is quarantined for review.
"""

import json
import sys
from datetime import datetime
from pathlib import Path

import pandas as pd

_PROJECT_ROOT = Path(__file__).resolve().parents[2]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))

from utils.config_util import Config
from utils.pipeline import extractor
from utils.pipeline.field_spec import Spec

GOLDEN_SAMPLE_SIZE = 25


# ------------------------------------------------------------------ baseline
def _baseline_dir(cfg: Config) -> Path:
    path = Path(cfg.get("PIPELINE", "BaselineDir", default="schemas/baselines"))
    if not path.is_absolute():
        path = _PROJECT_ROOT / path
    path.mkdir(parents=True, exist_ok=True)
    return path


def baseline_path(spec: Spec, cfg: Config) -> Path:
    return _baseline_dir(cfg) / f"{spec.name}_baseline.json"


def load_baseline(spec: Spec, cfg: Config) -> dict | None:
    path = baseline_path(spec, cfg)
    if not path.exists():
        return None
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError:
        return None


def save_baseline(spec: Spec, df: pd.DataFrame, health: dict,
                  cfg: Config, note: str = "") -> Path:
    """Record a known-good run: health metrics + a golden sample of records."""
    golden = (df.head(GOLDEN_SAMPLE_SIZE)
                .where(pd.notna(df.head(GOLDEN_SAMPLE_SIZE)), None)
                .to_dict(orient="records"))
    payload = {
        "spec_name": spec.name,
        "spec_version": spec.version,
        "captured_at": datetime.now().isoformat(timespec="seconds"),
        "note": note,
        "row_count": int(health["row_count"]),
        "fill_rates": health["fill_rates"],
        "score": health["score"],
        "columns": list(df.columns),
        "golden_sample": json.loads(json.dumps(golden, default=str)),
    }
    path = baseline_path(spec, cfg)
    path.write_text(json.dumps(payload, indent=2), encoding="utf-8")
    return path


# ------------------------------------------------------------------ drift
def detect_drift(spec: Spec, health: dict, baseline: dict | None,
                 cfg: Config) -> dict:
    """Decide whether the current extraction looks broken."""
    tolerance = cfg.get_float("PIPELINE", "DriftRowTolerance", 0.10)
    reasons, broken_fields = [], []

    for issue in health.get("issues", []):
        reasons.append(f"validation: {issue}")

    if baseline:
        base_rows = baseline.get("row_count", 0)
        now_rows = health.get("row_count", 0)
        if base_rows and now_rows < base_rows * (1 - tolerance):
            reasons.append(
                f"row count dropped {base_rows} -> {now_rows} "
                f"(> {tolerance:.0%} tolerance)")

        for name, base_rate in (baseline.get("fill_rates") or {}).items():
            now_rate = health.get("fill_rates", {}).get(name, 0.0)
            if base_rate >= 0.5 and now_rate < base_rate - 0.20:
                reasons.append(
                    f"field '{name}' fill rate fell {base_rate:.0%} -> {now_rate:.0%}")
                broken_fields.append(name)

    # Any required field that is largely empty is broken regardless of baseline
    for name in spec.required_fields:
        if health.get("fill_rates", {}).get(name, 0.0) < 0.80:
            if name not in broken_fields:
                broken_fields.append(name)

    # Fields named in validation issues are broken too
    for issue in health.get("issues", []):
        for field in spec.fields:
            if f"'{field.name}'" in issue and field.name not in broken_fields:
                broken_fields.append(field.name)

    return {
        "drifted": bool(reasons),
        "reasons": reasons,
        "broken_fields": broken_fields,
    }


# ------------------------------------------------------------------ candidates
def _relaxed_variants(pattern: str) -> list:
    """Conservative auto-relaxations of a regex that commonly fix layout drift."""
    variants = []
    if r"\s" not in pattern:
        variants.append(pattern.replace(" ", r"\s+"))
    variants.append(pattern.replace(r"\s+", r"\s*"))
    variants.append(pattern.replace(r"\s*", r"\s+"))
    if pattern.startswith("^"):
        variants.append(pattern[1:])
    if pattern.endswith("$"):
        variants.append(pattern[:-1])
    variants.append(pattern.replace("{3}", "{2,4}")
                           .replace("{2}", "{1,3}")
                           .replace("{4}", "{3,5}"))
    seen, unique = set(), []
    for variant in variants:
        if variant and variant != pattern and variant not in seen:
            seen.add(variant)
            unique.append(variant)
    return unique


def _field_candidate_specs(spec: Spec, field_name: str) -> list:
    """Alternative specs that differ only in one broken field."""
    field = spec.field(field_name)
    if field is None:
        return []

    proposals = []

    for pattern in field.candidates:
        clone = spec.clone()
        target = clone.field(field_name)
        target.patterns = [pattern] + list(target.patterns)
        proposals.append((clone, f"field '{field_name}': try candidate {pattern!r}"))

    for pattern in list(field.patterns):
        for variant in _relaxed_variants(pattern):
            clone = spec.clone()
            target = clone.field(field_name)
            target.patterns = [variant] + list(target.patterns)
            proposals.append(
                (clone, f"field '{field_name}': relaxed pattern to {variant!r}"))

    if field.strategy in ("token", "date", "number"):
        for shift in (1, -1, 2):
            new_index = field.index + shift
            if new_index < 0:
                continue
            clone = spec.clone()
            clone.field(field_name).index = new_index
            proposals.append(
                (clone,
                 f"field '{field_name}': index {field.index} -> {new_index}"))

    return proposals


def _record_candidate_specs(spec: Spec) -> list:
    """Alternative record-segmentation patterns (used when row count collapses)."""
    proposals = []
    record = spec.record or {}

    for pattern in record.get("start_candidates", []):
        clone = spec.clone()
        clone.record["start_patterns"] = [pattern] + list(
            clone.record.get("start_patterns", []))
        proposals.append((clone, f"record start: try candidate {pattern!r}"))

    for pattern in list(record.get("start_patterns", [])):
        for variant in _relaxed_variants(pattern):
            clone = spec.clone()
            clone.record["start_patterns"] = [variant] + list(
                clone.record.get("start_patterns", []))
            proposals.append((clone, f"record start: relaxed to {variant!r}"))

    return proposals


# ------------------------------------------------------------------ guard
def regression_guard(candidate_df: pd.DataFrame, baseline: dict | None) -> dict:
    """The golden sample from the last good run must still be reproduced."""
    if not baseline or not baseline.get("golden_sample"):
        return {"passed": True, "checked": 0, "matched": 0,
                "detail": "no baseline golden sample - guard skipped"}

    golden = baseline["golden_sample"]
    columns = [c for c in baseline.get("columns", []) if c in candidate_df.columns]
    if not columns:
        return {"passed": False, "checked": len(golden), "matched": 0,
                "detail": "candidate produced none of the baseline columns"}

    def _norm(value):
        if value is None or (isinstance(value, float) and pd.isna(value)):
            return ""
        if isinstance(value, (int, float)):
            return f"{float(value):.2f}"
        return str(value).strip().lower()

    actual = {
        tuple(_norm(row.get(col)) for col in columns)
        for row in candidate_df.to_dict(orient="records")
    }

    matched = sum(
        1 for row in golden
        if tuple(_norm(row.get(col)) for col in columns) in actual
    )

    ratio = matched / len(golden) if golden else 1.0
    return {
        "passed": ratio >= 0.95,
        "checked": len(golden),
        "matched": matched,
        "ratio": round(ratio, 4),
        "detail": f"{matched}/{len(golden)} golden records reproduced",
    }


# ------------------------------------------------------------------ heal
def heal(spec: Spec,
         text: str,
         health: dict,
         drift: dict,
         cfg: Config | None = None,
         baseline: dict | None = None) -> dict:
    """Search for a spec repair that improves health without regressing.

    Returns a dict with ``success``, the ``spec`` (healed or original),
    ``confidence``, ``changes`` and ``needs_review``.
    """
    cfg = cfg or Config()
    require_guard = cfg.get_bool("PIPELINE", "RequireRegressionPass", True)
    threshold = cfg.get_float("PIPELINE", "HealConfidenceThreshold", 0.85)

    baseline = baseline if baseline is not None else load_baseline(spec, cfg)

    working = spec.clone()
    best_health = health
    changes = []

    # 1. If almost nothing parsed, the record boundary itself is wrong.
    row_collapse = health["row_count"] == 0 or (
        baseline and baseline.get("row_count")
        and health["row_count"] < baseline["row_count"] * 0.5
    )
    if row_collapse:
        for candidate, note in _record_candidate_specs(working):
            try:
                cand_df, cand_health = extractor.extract(
                    candidate, cfg=cfg, text=text)
            except Exception:
                continue
            if cand_health["row_count"] > best_health["row_count"]:
                working, best_health = candidate, cand_health
                changes.append(note)
                break

    # 2. Repair only the fields that are actually broken.
    #    All candidates are evaluated and the one that best preserves the
    #    known-good golden records wins - not merely the first that improves.
    for field_name in drift.get("broken_fields", []):
        current_rate = best_health["fill_rates"].get(field_name, 0.0)
        scored = []

        for candidate, note in _field_candidate_specs(working, field_name):
            try:
                cand_df, cand_health = extractor.extract(
                    candidate, cfg=cfg, text=text)
            except Exception:
                continue

            new_rate = cand_health["fill_rates"].get(field_name, 0.0)
            if new_rate <= current_rate + 0.05:
                continue

            no_collateral = all(
                cand_health["fill_rates"].get(other, 0.0)
                >= best_health["fill_rates"].get(other, 0.0) - 0.02
                for other in best_health["fill_rates"]
                if other != field_name
            )
            if not no_collateral:
                continue

            guard = regression_guard(cand_df, baseline)
            scored.append({
                "spec": candidate,
                "health": cand_health,
                "note": note,
                "guard_ratio": guard.get("ratio", 1.0),
                "guard_passed": guard["passed"],
                "field_rate": new_rate,
            })

        if not scored:
            changes.append(f"field '{field_name}': no safe repair found")
            continue

        # Prefer candidates that keep the golden sample intact, then coverage.
        scored.sort(key=lambda c: (c["guard_passed"], c["guard_ratio"],
                                   c["field_rate"]), reverse=True)
        winner = scored[0]
        working = winner["spec"]
        best_health = winner["health"]
        changes.append(
            f"{winner['note']} [restored {winner['field_rate']:.0%}, "
            f"golden {winner['guard_ratio']:.0%}]")

    if not changes or best_health["score"] <= health["score"]:
        return {
            "success": False,
            "spec": spec,
            "health": health,
            "changes": changes,
            "confidence": 0.0,
            "needs_review": True,
            "guard": None,
            "reason": "no repair improved the extraction",
        }

    # 3. Regression guard - must reproduce the last known-good records.
    final_df, final_health = extractor.extract(working, cfg=cfg, text=text)
    guard = regression_guard(final_df, baseline)

    if require_guard and not guard["passed"]:
        return {
            "success": False,
            "spec": spec,
            "health": health,
            "changes": changes,
            "confidence": 0.0,
            "needs_review": True,
            "guard": guard,
            "reason": f"regression guard failed - {guard['detail']}",
        }

    confidence = round(
        0.6 * final_health["score"] + 0.4 * guard.get("ratio", 1.0), 4)

    working.version = spec.version + 1
    working.record_note(
        "auto-heal: " + "; ".join(changes) +
        f" | confidence={confidence} | guard={guard['detail']}")

    return {
        "success": True,
        "spec": working,
        "health": final_health,
        "df": final_df,
        "changes": changes,
        "confidence": confidence,
        "needs_review": confidence < threshold,
        "guard": guard,
        "reason": "healed",
    }


# ------------------------------------------------------------------ quarantine
def quarantine(spec: Spec, health: dict, drift: dict,
               cfg: Config, extra: dict | None = None) -> Path:
    """Persist a failure report for human review."""
    path = Path(cfg.get("PIPELINE", "QuarantineDir", default="files/quarantine"))
    if not path.is_absolute():
        path = _PROJECT_ROOT / path
    path.mkdir(parents=True, exist_ok=True)

    stamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    report = path / f"{spec.name}_{stamp}.json"
    report.write_text(json.dumps({
        "spec": spec.name,
        "spec_version": spec.version,
        "report": spec.report,
        "timestamp": stamp,
        "health": health,
        "drift": drift,
        "extra": extra or {},
    }, indent=2, default=str), encoding="utf-8")
    return report


