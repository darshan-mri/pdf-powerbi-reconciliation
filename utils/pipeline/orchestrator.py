"""End-to-end runner: PDF extract (self-healing) -> Power BI fetch -> compare.

    python utils/pipeline/orchestrator.py CM.ROLL
    python utils/pipeline/orchestrator.py CM.AGED --period 01/26
    python utils/pipeline/orchestrator.py all --skip-fetch
    python utils/pipeline/orchestrator.py CM.ROLL --approve-baseline

Exit code is non-zero when a report has mismatches or needs human review, so
this can be wired straight into a scheduler or CI job.
"""

import argparse
import sys
import traceback
from datetime import datetime
from pathlib import Path

import pandas as pd

_PROJECT_ROOT = Path(__file__).resolve().parents[2]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))

from utils.config_util import Config
from utils.pipeline import extractor, healer
from utils.pipeline.field_spec import Spec

# --------------------------------------------------------------------------
# Comparison definitions.
#
# `report_rename`  maps the Power BI export's column names onto the canonical
#                  names produced by the PDF extraction. Manual exports and DAX
#                  output can therefore both be compared without code changes.
# `report_derive`  builds a canonical column the report doesn't ship (e.g. the
#                  aged report has no Total column - it is the sum of buckets).
# `key_transform`  normalises a key that is formatted differently on each side
#                  (e.g. "300B01 - 1822 Scarth St" -> "300B01").
# --------------------------------------------------------------------------
COMPARISON = {
    "CM.ROLL": {
        "keys": ["Building ID", "Suite ID"],
        "compare": ["GLA Sqft", "Monthly Base Rent", "Annual Rate PSF"],
        "tolerance": 0.01,
        "output_key": "ComparisonAuto",
        "report_rename": {
            "Building ID - Name": "Building ID",
            "Total Sq. Ft": "GLA Sqft",
            "Monthly Rent": "Monthly Base Rent",
            "Annual Rent PSF": "Annual Rate PSF",
        },
        "report_derive": {},
        "key_transform": {"Suite ID": "squash"},
        "report_key_transform": {"Building ID": "before_dash"},
        "aggregate": None,
    },
    "CM.AGED": {
        "keys": ["Tenant"],
        "compare": ["Total", "Current", "Month_1", "Month_2", "Month_3", "Month_4"],
        "tolerance": 0.01,
        "output_key": "ComparisonAuto",
        "report_rename": {
            "OccupantName": "Tenant",
            "By Period Open Charges": "Total",
            "By Period 1st Month Open Charges": "Month_1",
            "By Period 2nd Month Open Charges": "Month_2",
            "By Period 3rd Month Open Charges": "Month_3",
            "By Period 4+ Months Open Charges": "Month_4",
        },
        # The export has no explicit Current bucket - it is the remainder.
        "report_derive": {
            "Current": {"minus": ["Total", "Month_1", "Month_2",
                                  "Month_3", "Month_4"]},
        },
        "key_transform": {"Tenant": "squash"},
        "aggregate": "sum",
    },

    # ---- Dolben CM Rent Roll ------------------------------------------
    # Same canonical columns as CM.ROLL, so the identical comparison rules
    # apply - only the extraction technique differs.
    "DOLBEN.CMROLL": {
        "keys": ["Building ID", "Suite ID"],
        "compare": ["GLA Sqft", "Monthly Base Rent", "Annual Rate PSF",
                    "Monthly Cost Recovery", "Monthly Other Income"],
        "tolerance": 0.01,
        "output_key": "ComparisonAuto",
        "report_rename": {
            "Building ID - Name": "Building ID",
            "Total Sq. Ft": "GLA Sqft",
            "Monthly Rent": "Monthly Base Rent",
            "Annual Rent PSF": "Annual Rate PSF",
        },
        "report_derive": {},
        "key_transform": {"Suite ID": "squash"},
        "report_key_transform": {"Building ID": "before_dash"},
        "aggregate": None,
    },

    # ---- BPG RM Aged Delinquency --------------------------------------
    "BPG.AGED": {
        "keys": ["OccupantName"],
        "compare": ["Total", "Current", "Month_1", "Month_2", "Month_3", "Month_4"],
        "tolerance": 0.01,
        "output_key": "ComparisonAuto",
        "report_rename": {
            "Occupant Name": "OccupantName",
            "Tenant": "OccupantName",
            "By Period Open Charges": "Total",
            "By Period 1st Month Open Charges": "Month_1",
            "By Period 2nd Month Open Charges": "Month_2",
            "By Period 3rd Month Open Charges": "Month_3",
            "By Period 4+ Months Open Charges": "Month_4",
        },
        "report_derive": {
            "Current": {"minus": ["Total", "Month_1", "Month_2",
                                  "Month_3", "Month_4"]},
        },
        "key_transform": {"OccupantName": "squash"},
        "aggregate": "sum",
    },

    # ---- BPG Detailed Rent Roll ---------------------------------------
    "BPG.DETROLL": {
        "keys": ["Property", "Unit"],
        "compare": ["Market Rent", "Lease Rent", "Total Billing",
                    "Deposit On Hand", "Balance"],
        "tolerance": 0.01,
        "output_key": "ComparisonAuto",
        "report_rename": {
            "Property Id": "Property",
            "PropertyId": "Property",
            "Unit Id": "Unit",
            "UnitId": "Unit",
        },
        "report_derive": {},
        "key_transform": {"Property": "squash", "Unit": "squash"},
        "aggregate": "sum",
    },

    # ---- BPG Property Status Report -----------------------------------
    "BPG.PROPSTATUS": {
        "keys": ["Property Code"],
        "compare": ["Total Units", "Total Leased", "Total Available",
                    "Occupancy %"],
        "tolerance": 0.01,
        "output_key": "ComparisonAuto",
        "report_rename": {
            "PropertyCode": "Property Code",
            "Property Id": "Property Code",
            "Units": "Total Units",
            "Leased": "Total Leased",
            "Available": "Total Available",
        },
        "report_derive": {},
        "key_transform": {"Property Code": "squash"},
        "aggregate": "sum",
    },
}

SUPPORTED = list(COMPARISON)


# --------------------------------------------------------------------------
# Step 1 - extraction with drift detection + guarded healing
# --------------------------------------------------------------------------
def run_extraction(report: str, cfg: Config, auto_heal: bool | None = None) -> dict:
    """Extract from the PDF, healing the spec if the layout drifted."""
    spec = Spec.for_report(report, cfg)
    source_key = (spec.source or {}).get("config_key", "PDF")
    pdf_path = cfg.get(report, source_key)
    engine = (spec.source or {}).get("engine", "pymupdf")

    print(f"\n[{report}] Extracting  spec={spec.name} v{spec.version}")
    print(f"[{report}] PDF: {pdf_path}")

    is_custom = spec.mode == "custom"
    if is_custom:
        print(f"[{report}] Handler: {(spec.source or {}).get('handler')}")
        text = None
        df, health = extractor.extract(spec, pdf_path=pdf_path, cfg=cfg)
    else:
        text = extractor.read_pdf_text(pdf_path, engine)
        df, health = extractor.extract(spec, cfg=cfg, text=text)

    baseline = healer.load_baseline(spec, cfg)
    drift = healer.detect_drift(spec, health, baseline, cfg)

    print(f"[{report}] Rows={health['row_count']}  score={health['score']:.2%}")

    result = {
        "spec": spec, "df": df, "health": health, "drift": drift,
        "healed": False, "needs_review": False, "quarantine": None,
        "changes": [], "confidence": None,
    }

    if not drift["drifted"]:
        print(f"[{report}] Layout OK - no drift detected.")
        return result

    print(f"[{report}] !! LAYOUT DRIFT DETECTED")
    for reason in drift["reasons"]:
        print(f"[{report}]    - {reason}")

    # Custom handlers are real Python parsers, not declarative patterns, so
    # there is nothing safe to auto-rewrite. Flag for a human instead.
    if is_custom:
        result["needs_review"] = True
        result["quarantine"] = healer.quarantine(
            spec, health, drift, cfg,
            {"note": "custom handler - auto-repair not applicable",
             "handler": (spec.source or {}).get("handler")})
        print(f"[{report}] Custom handler cannot be auto-repaired - "
              f"FLAGGED FOR REVIEW: {result['quarantine']}")
        return result

    if auto_heal is None:
        auto_heal = cfg.get_bool("PIPELINE", "AutoHeal", True)

    if not auto_heal:
        result["needs_review"] = True
        result["quarantine"] = healer.quarantine(spec, health, drift, cfg)
        print(f"[{report}] AutoHeal disabled - quarantined: {result['quarantine']}")
        return result

    print(f"[{report}] Attempting guarded auto-repair...")
    outcome = healer.heal(spec, text, health, drift, cfg, baseline)
    result["changes"] = outcome["changes"]
    result["confidence"] = outcome["confidence"]

    if not outcome["success"]:
        result["needs_review"] = True
        result["quarantine"] = healer.quarantine(
            spec, health, drift, cfg, {"heal_reason": outcome["reason"],
                                       "attempted": outcome["changes"]})
        print(f"[{report}] Auto-repair FAILED: {outcome['reason']}")
        print(f"[{report}] Original spec left untouched. "
              f"Quarantined: {result['quarantine']}")
        return result

    healed_spec = outcome["spec"]
    healed_spec.save(backup=True)
    print(f"[{report}] Auto-repair SUCCEEDED "
          f"(v{spec.version} -> v{healed_spec.version}, "
          f"confidence {outcome['confidence']:.0%})")
    for change in outcome["changes"]:
        print(f"[{report}]    * {change}")
    print(f"[{report}]    guard: {outcome['guard']['detail']}")

    result.update({
        "spec": healed_spec,
        "df": outcome["df"],
        "health": outcome["health"],
        "healed": True,
        "needs_review": outcome["needs_review"],
    })
    if outcome["needs_review"]:
        print(f"[{report}] Confidence below threshold - FLAGGED FOR HUMAN REVIEW.")
    return result


def save_extraction(report: str, spec: Spec, df: pd.DataFrame, cfg: Config) -> Path:
    out_key = (spec.output or {}).get("config_key", "ExtractedAuto")
    sheet = (spec.output or {}).get("sheet", "Sheet1")
    out = Path(cfg.get(report, out_key))
    out.parent.mkdir(parents=True, exist_ok=True)
    try:
        with pd.ExcelWriter(out, engine="openpyxl") as writer:
            df.to_excel(writer, sheet_name=sheet, index=False)
    except PermissionError:
        stamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        out = out.with_name(f"{out.stem}_{stamp}{out.suffix}")
        with pd.ExcelWriter(out, engine="openpyxl") as writer:
            df.to_excel(writer, sheet_name=sheet, index=False)
    print(f"[{report}] Extracted data -> {out}")
    return out


# --------------------------------------------------------------------------
# Step 2 - Power BI fetch
# --------------------------------------------------------------------------
def run_fetch(report: str, cfg: Config, period: str | None = None) -> Path | None:
    from utils.pipeline.fetch_report import fetch_report
    try:
        return fetch_report(report, cfg=cfg, period=period)
    except Exception as exc:
        print(f"[{report}] Power BI fetch failed: {exc}")
        print(f"[{report}] Falling back to the existing ReportExcel file.")
        return None


# --------------------------------------------------------------------------
# Step 3 - comparison
# --------------------------------------------------------------------------
def _normalise_keys(df: pd.DataFrame, keys: list,
                    transforms: dict | None = None) -> pd.DataFrame:
    """Make join keys comparable across PDF text and Power BI output.

    ``squash`` strips every non-alphanumeric character, which is essential
    because PDF text extraction frequently loses spaces
    ("AvivaCanada Inc" vs "Aviva Canada Inc").
    """
    transforms = transforms or {}
    for key in keys:
        if key not in df.columns:
            continue
        series = df[key].astype(str)
        rule = transforms.get(key)
        if rule == "before_dash":
            series = series.str.split("-").str[0]
        if rule == "squash":
            series = series.str.lower().str.replace(r"[^a-z0-9]", "", regex=True)
        else:
            series = (series.str.strip().str.lower()
                      .str.replace(r"\s+", " ", regex=True))
        df[key] = series
    return df


def _aggregate(df: pd.DataFrame, keys: list, value_cols: list,
               how: str | None) -> pd.DataFrame:
    """Collapse duplicate keys so the merge cannot fan out into a cross join."""
    if not how:
        return df
    present = [c for c in value_cols if c in df.columns]
    if not present:
        return df
    for col in present:
        df[col] = pd.to_numeric(df[col], errors="coerce")
    return df.groupby(keys, as_index=False)[present].agg(how)


def _prepare_report_frame(report_df: pd.DataFrame, rules: dict) -> pd.DataFrame:
    """Rename / derive columns so the export matches the canonical schema."""
    rename = {k: v for k, v in (rules.get("report_rename") or {}).items()
              if k in report_df.columns}
    report_df = report_df.rename(columns=rename)

    for target, recipe in (rules.get("report_derive") or {}).items():
        if target in report_df.columns:
            continue
        if isinstance(recipe, dict) and "minus" in recipe:
            sources = recipe["minus"]
            if not all(c in report_df.columns for c in sources):
                continue
            head, *rest = sources
            value = pd.to_numeric(report_df[head], errors="coerce").fillna(0)
            for col in rest:
                value = value - pd.to_numeric(report_df[col], errors="coerce").fillna(0)
            report_df[target] = value
        else:
            sources = list(recipe)
            if not all(c in report_df.columns for c in sources):
                continue
            report_df[target] = sum(
                pd.to_numeric(report_df[c], errors="coerce").fillna(0)
                for c in sources)
    return report_df


def run_comparison(report: str, extracted: pd.DataFrame,
                   cfg: Config) -> dict:
    rules = COMPARISON[report]
    keys, compare_cols = rules["keys"], rules["compare"]
    tolerance = rules["tolerance"]

    report_path = Path(cfg.get(report, "ReportExcel"))
    if not report_path.exists():
        raise FileNotFoundError(
            f"Report export not found: {report_path}. "
            f"Run the Power BI fetch first (or export it manually).")

    report_df = pd.read_excel(report_path)
    extracted = extracted.copy()

    extracted.columns = [str(c).strip() for c in extracted.columns]
    report_df.columns = [str(c).strip() for c in report_df.columns]
    report_df = _prepare_report_frame(report_df, rules)

    missing_keys = [k for k in keys if k not in report_df.columns]
    if missing_keys:
        raise KeyError(
            f"[{report}] Report export is missing key column(s) {missing_keys}. "
            f"Available: {list(report_df.columns)}")

    transforms = rules.get("key_transform") or {}
    extracted = _normalise_keys(extracted, keys, transforms)
    report_df = _normalise_keys(report_df, keys,
                                {**transforms, **(rules.get("report_key_transform") or {})})

    usable = [c for c in compare_cols if c in report_df.columns]
    skipped = [c for c in compare_cols if c not in report_df.columns]
    if skipped:
        print(f"[{report}] Skipping columns absent from the report: {skipped}")

    for col in usable:
        for frame in (extracted, report_df):
            if col in frame.columns:
                frame[col] = pd.to_numeric(frame[col], errors="coerce")

    aggregate = rules.get("aggregate")
    extracted = _aggregate(extracted, keys,
                           [c for c in usable if c in extracted.columns], aggregate)
    report_df = _aggregate(report_df, keys, usable, aggregate)

    merged = pd.merge(
        extracted[keys + [c for c in usable if c in extracted.columns]],
        report_df[keys + usable],
        on=keys, how="outer", suffixes=("_Extracted", "_Report"),
        indicator=True,
    )

    match_cols = []
    for col in usable:
        left, right = f"{col}_Extracted", f"{col}_Report"
        if left not in merged.columns or right not in merged.columns:
            continue
        diff = (merged[left].fillna(0) - merged[right].fillna(0)).abs()
        merged[f"{col}_Diff"] = diff.round(2)
        merged[f"{col}_Match"] = diff <= tolerance
        match_cols.append(f"{col}_Match")

    merged["Overall_Match"] = merged[match_cols].all(axis=1) if match_cols else True
    merged["Row_Source"] = merged["_merge"].map({
        "both": "In both",
        "left_only": "PDF only",
        "right_only": "Report only",
    })
    merged = merged.drop(columns=["_merge"])
    merged["Needs_Review"] = (~merged["Overall_Match"]) | (merged["Row_Source"] != "In both")

    out = Path(cfg.get(report, rules["output_key"]))
    out.parent.mkdir(parents=True, exist_ok=True)
    review = merged[merged["Needs_Review"]]

    try:
        writer_target = out
        with pd.ExcelWriter(writer_target, engine="openpyxl") as writer:
            merged.to_excel(writer, sheet_name="Comparison", index=False)
            review.to_excel(writer, sheet_name="Needs Review", index=False)
    except PermissionError:
        stamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        writer_target = out.with_name(f"{out.stem}_{stamp}{out.suffix}")
        with pd.ExcelWriter(writer_target, engine="openpyxl") as writer:
            merged.to_excel(writer, sheet_name="Comparison", index=False)
            review.to_excel(writer, sheet_name="Needs Review", index=False)

    print(f"[{report}] Compared {len(merged)} rows -> {writer_target}")
    print(f"[{report}] Matches: {int(merged['Overall_Match'].sum())} | "
          f"Needs review: {len(review)}")

    return {
        "path": writer_target,
        "total": len(merged),
        "matched": int(merged["Overall_Match"].sum()),
        "review": len(review),
        "df": merged,
    }


# --------------------------------------------------------------------------
# Orchestration
# --------------------------------------------------------------------------
def run_report(report: str,
               cfg: Config,
               skip_fetch: bool = False,
               skip_compare: bool = False,
               period: str | None = None,
               auto_heal: bool | None = None,
               approve_baseline: bool = False) -> dict:
    print("=" * 74)
    print(f"REPORT: {report}")
    print("=" * 74)

    summary = {"report": report, "ok": False, "needs_review": False}

    extraction = run_extraction(report, cfg, auto_heal=auto_heal)
    summary["healed"] = extraction["healed"]
    summary["needs_review"] = extraction["needs_review"]
    summary["rows_extracted"] = extraction["health"]["row_count"]

    if extraction["health"]["row_count"] == 0:
        print(f"[{report}] Nothing extracted - stopping before comparison.")
        return summary

    save_extraction(report, extraction["spec"], extraction["df"], cfg)

    if approve_baseline:
        path = healer.save_baseline(
            extraction["spec"], extraction["df"], extraction["health"], cfg,
            note="approved by operator")
        print(f"[{report}] Baseline approved and stored -> {path}")

    if not skip_fetch:
        run_fetch(report, cfg, period=period)

    if skip_compare:
        summary["ok"] = not summary["needs_review"]
        return summary

    try:
        comparison = run_comparison(report, extraction["df"], cfg)
        summary.update({
            "compared": comparison["total"],
            "matched": comparison["matched"],
            "review_rows": comparison["review"],
            "result_path": str(comparison["path"]),
        })
        summary["ok"] = comparison["review"] == 0 and not summary["needs_review"]
        if comparison["review"]:
            summary["needs_review"] = True
    except Exception as exc:
        print(f"[{report}] Comparison failed: {exc}")
        summary["error"] = str(exc)

    # A clean, drift-free, fully matching run becomes the new baseline.
    if summary.get("ok") and not extraction["drift"]["drifted"]:
        healer.save_baseline(extraction["spec"], extraction["df"],
                             extraction["health"], cfg, note="clean automated run")

    return summary


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Run the PDF vs Power BI validation pipeline.")
    parser.add_argument("report", help=f"{', '.join(SUPPORTED)} or 'all'")
    parser.add_argument("--period", help="Override the __PERIOD__ DAX filter")
    parser.add_argument("--skip-fetch", action="store_true",
                        help="Use the existing ReportExcel instead of calling Power BI")
    parser.add_argument("--skip-compare", action="store_true",
                        help="Extract only")
    parser.add_argument("--no-heal", action="store_true",
                        help="Disable auto-repair; quarantine drift instead")
    parser.add_argument("--approve-baseline", action="store_true",
                        help="Store this run as the known-good baseline")
    args = parser.parse_args()

    cfg = Config()
    reports = SUPPORTED if args.report.lower() == "all" else [args.report.upper()]

    unknown = [r for r in reports if r not in COMPARISON]
    if unknown:
        parser.error(f"Unsupported report(s): {unknown}. Supported: {SUPPORTED}")

    summaries = []
    for report in reports:
        try:
            summaries.append(run_report(
                report, cfg,
                skip_fetch=args.skip_fetch,
                skip_compare=args.skip_compare,
                period=args.period,
                auto_heal=False if args.no_heal else None,
                approve_baseline=args.approve_baseline,
            ))
        except Exception as exc:
            traceback.print_exc()
            summaries.append({"report": report, "ok": False, "error": str(exc)})

    print("\n" + "=" * 74)
    print("SUMMARY")
    print("=" * 74)
    for summary in summaries:
        status = "OK" if summary.get("ok") else (
            "REVIEW" if summary.get("needs_review") else "FAILED")
        print(f"  {summary['report']:<12} {status:<8} "
              f"extracted={summary.get('rows_extracted', '-')} "
              f"matched={summary.get('matched', '-')} "
              f"review={summary.get('review_rows', summary.get('needs_review'))}"
              + (f"  healed(v+1)" if summary.get("healed") else "")
              + (f"  error={summary['error']}" if summary.get("error") else ""))

    sys.exit(0 if all(s.get("ok") for s in summaries) else 1)


if __name__ == "__main__":
    main()













