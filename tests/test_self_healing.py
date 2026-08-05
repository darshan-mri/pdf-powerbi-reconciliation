"""Self-healing verification harness.

Deliberately breaks a schema, then proves the pipeline:
  1. DETECTS the drift,
  2. REPAIRS it automatically,
  3. REFUSES repairs that would regress known-good output,
  4. NEVER corrupts the original schema on failure.

Run:  python tests/test_self_healing.py
"""

import json
import sys
from pathlib import Path

_PROJECT_ROOT = Path(__file__).resolve().parents[1]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))

from utils.config_util import Config
from utils.pipeline import extractor, healer
from utils.pipeline.field_spec import Spec

PASS, FAIL = "PASS", "FAIL"
results = []


def check(name, condition, detail=""):
    status = PASS if condition else FAIL
    results.append((status, name, detail))
    print(f"  [{status}] {name}" + (f"  ({detail})" if detail else ""))
    return condition


def _load_text(spec, cfg):
    pdf = cfg.get(spec.report, (spec.source or {}).get("config_key", "PDF"))
    return extractor.read_pdf_text(pdf, (spec.source or {}).get("engine", "pymupdf"))


# ---------------------------------------------------------------------------
def scenario_field_break(report, field_name, broken_pattern):
    """A field's regex stops matching -> healer should repair just that field."""
    print(f"\n--- {report}: break field '{field_name}' ---")
    cfg = Config()
    original = Spec.for_report(report, cfg)
    schema_path = Path(original.path)
    backup = schema_path.read_text(encoding="utf-8")

    try:
        text = _load_text(original, cfg)
        good_df, good_health = extractor.extract(original, cfg=cfg, text=text)
        baseline = healer.load_baseline(original, cfg)

        broken = original.clone()
        broken.field(field_name).patterns = [broken_pattern]
        broken_df, broken_health = extractor.extract(broken, cfg=cfg, text=text)

        good_rate = good_health["fill_rates"][field_name]
        broken_rate = broken_health["fill_rates"][field_name]
        check("breaking the pattern degrades the field",
              broken_rate < good_rate,
              f"{good_rate:.0%} -> {broken_rate:.0%}")

        drift = healer.detect_drift(broken, broken_health, baseline, cfg)
        check("drift is detected", drift["drifted"],
              f"{len(drift['reasons'])} reason(s)")
        check("the broken field is identified",
              field_name in drift["broken_fields"],
              str(drift["broken_fields"]))

        outcome = healer.heal(broken, text, broken_health, drift, cfg, baseline)
        check("auto-repair succeeds", outcome["success"], outcome["reason"])

        if outcome["success"]:
            healed_rate = outcome["health"]["fill_rates"][field_name]
            check("field is restored",
                  healed_rate >= good_rate - 0.02,
                  f"{broken_rate:.0%} -> {healed_rate:.0%}")
            check("regression guard passed", outcome["guard"]["passed"],
                  outcome["guard"]["detail"])
            check("other fields not damaged",
                  all(outcome["health"]["fill_rates"].get(f, 0)
                      >= good_health["fill_rates"].get(f, 0) - 0.02
                      for f in good_health["fill_rates"] if f != field_name))
            check("spec version incremented",
                  outcome["spec"].version == broken.version + 1,
                  f"v{broken.version} -> v{outcome['spec'].version}")
            check("an audit note was recorded",
                  len(outcome["spec"].history) > len(broken.history))
    finally:
        schema_path.write_text(backup, encoding="utf-8")
        print(f"  (restored {schema_path.name})")


# ---------------------------------------------------------------------------
def scenario_unhealable(report):
    """Garbage that cannot be repaired must NOT be accepted or written."""
    print(f"\n--- {report}: unrepairable break (guard must reject) ---")
    cfg = Config()
    original = Spec.for_report(report, cfg)
    schema_path = Path(original.path)
    backup = schema_path.read_text(encoding="utf-8")

    try:
        text = _load_text(original, cfg)
        baseline = healer.load_baseline(original, cfg)

        broken = original.clone()
        key = "end_patterns" if broken.mode == "block_end" else "start_patterns"
        broken.record[key] = ["ZZZ_NO_SUCH_MARKER_ZZZ"]
        broken.record.pop("start_candidates", None)

        df, health = extractor.extract(broken, cfg=cfg, text=text)
        check("extraction collapses to zero rows", health["row_count"] == 0,
              f"rows={health['row_count']}")

        drift = healer.detect_drift(broken, health, baseline, cfg)
        check("drift is detected", drift["drifted"])

        outcome = healer.heal(broken, text, health, drift, cfg, baseline)
        check("unrepairable break is REJECTED", not outcome["success"],
              outcome["reason"])
        check("original spec object returned untouched",
              outcome["spec"].version == broken.version)

        on_disk = json.loads(schema_path.read_text(encoding="utf-8"))
        check("schema file on disk was NOT modified",
              on_disk == json.loads(backup))

        report_path = healer.quarantine(broken, health, drift, cfg)
        check("failure is quarantined for review", Path(report_path).exists(),
              Path(report_path).name)
    finally:
        schema_path.write_text(backup, encoding="utf-8")
        print(f"  (restored {schema_path.name})")


# ---------------------------------------------------------------------------
def scenario_regression_guard():
    """The guard itself must reject output that loses known-good records."""
    print("\n--- regression guard unit check ---")
    import pandas as pd

    baseline = {
        "columns": ["Tenant", "Total"],
        "golden_sample": [
            {"Tenant": "acme corp", "Total": 100.0},
            {"Tenant": "globex", "Total": 250.5},
        ],
    }
    good = pd.DataFrame([{"Tenant": "Acme Corp", "Total": 100.00},
                         {"Tenant": "Globex", "Total": 250.50},
                         {"Tenant": "New Co", "Total": 10.0}])
    bad = pd.DataFrame([{"Tenant": "Acme Corp", "Total": 999.99},
                        {"Tenant": "Other", "Total": 1.0}])

    check("guard accepts output preserving golden records",
          healer.regression_guard(good, baseline)["passed"])
    check("guard rejects output that lost golden records",
          not healer.regression_guard(bad, baseline)["passed"])
    check("guard is skipped when no baseline exists",
          healer.regression_guard(good, None)["passed"])


# ---------------------------------------------------------------------------
def scenario_partial_repair_refused(report, field_name, broken_pattern):
    """A repair that only PARTIALLY restores output must be refused.

    This is the most important safety property: a 'nearly right' pattern is
    more dangerous than an obviously broken one, because it silently produces
    wrong numbers. The guard must reject it.
    """
    print(f"\n--- {report}: partial repair of '{field_name}' must be refused ---")
    cfg = Config()
    original = Spec.for_report(report, cfg)
    schema_path = Path(original.path)
    backup = schema_path.read_text(encoding="utf-8")

    try:
        text = _load_text(original, cfg)
        baseline = healer.load_baseline(original, cfg)

        broken = original.clone()
        target = broken.field(field_name)
        target.patterns = [broken_pattern]
        # Only offer a candidate that is close but NOT equivalent.
        target.candidates = ["(?m)^\\s*([0-9]{3,5})\\s+(?:Inactive|Current|New)"]

        df, health = extractor.extract(broken, cfg=cfg, text=text)
        drift = healer.detect_drift(broken, health, baseline, cfg)
        check("drift is detected", drift["drifted"])

        outcome = healer.heal(broken, text, health, drift, cfg, baseline)
        check("partial repair is REFUSED by the guard",
              not outcome["success"], outcome["reason"])
        check("run is flagged for human review", outcome["needs_review"])

        on_disk = json.loads(schema_path.read_text(encoding="utf-8"))
        check("schema file on disk was NOT modified",
              on_disk == json.loads(backup))
    finally:
        schema_path.write_text(backup, encoding="utf-8")
        print(f"  (restored {schema_path.name})")


# ---------------------------------------------------------------------------
def scenario_custom_mode(report):
    """Custom-handler reports must extract, and must never be auto-rewritten."""
    print(f"\n--- {report}: custom handler integration ---")
    cfg = Config()
    spec = Spec.for_report(report, cfg)
    schema_path = Path(str(spec.path))
    backup = schema_path.read_text(encoding="utf-8")

    check("spec uses custom mode", spec.mode == "custom", spec.mode)
    check("a handler is declared", bool((spec.source or {}).get("handler")),
          str((spec.source or {}).get("handler")))

    pdf = cfg.get(spec.report, (spec.source or {}).get("config_key", "PDF"))
    df, health = extractor.extract(spec, pdf_path=pdf, cfg=cfg)
    check("extraction returns rows", health["row_count"] > 0,
          f"rows={health['row_count']}")
    check("no validation issues", not health["issues"], str(health["issues"]))
    check("all declared columns present",
          all(c in df.columns for c in spec.column_names))

    # Drift on a custom spec must be reported, never silently "repaired".
    broken_health = dict(health)
    broken_health["fill_rates"] = {k: 0.0 for k in health["fill_rates"]}
    broken_health["row_count"] = 0
    drift = healer.detect_drift(spec, broken_health, {"row_count": 999,
                                                      "fill_rates": {}}, cfg)
    check("drift on a custom spec is detected", drift["drifted"])

    on_disk = json.loads(schema_path.read_text(encoding="utf-8"))
    check("custom schema file untouched", on_disk == json.loads(backup))


# ---------------------------------------------------------------------------
def main():
    print("=" * 70)
    print("SELF-HEALING VERIFICATION")
    print("=" * 70)

    scenario_regression_guard()
    scenario_field_break("CM.AGED", "MasterOccupantID",
                         "MasterOccupantIdXX\\s*:\\s*([A-Z]+)")
    scenario_field_break("CM.AGED", "SuiteID",
                         "SuiteNumberXX\\s*:\\s*([0-9]+)")
    scenario_partial_repair_refused("CM.AGED", "SuiteID",
                                    "SuiteNumberXX\\s*:\\s*([0-9]+)")
    scenario_unhealable("CM.AGED")

    for report in ("DOLBEN.CMROLL", "BPG.AGED",
                   "BPG.DETROLL", "BPG.PROPSTATUS"):
        scenario_custom_mode(report)

    print("\n" + "=" * 70)
    passed = sum(1 for s, _, _ in results if s == PASS)
    failed = sum(1 for s, _, _ in results if s == FAIL)
    print(f"RESULT: {passed} passed, {failed} failed")
    for status, name, detail in results:
        if status == FAIL:
            print(f"   FAILED: {name} {detail}")
    print("=" * 70)
    sys.exit(1 if failed else 0)


if __name__ == "__main__":
    main()




