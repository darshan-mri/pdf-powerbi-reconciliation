"""Fetch a Power BI report table and write it to the configured ReportExcel.

This replaces the manual "open Power BI -> apply date/filters -> export table"
step. The output file is byte-for-byte the same *role* as the manual export, so
nothing downstream has to change.

Usage
-----
    python utils/pipeline/fetch_report.py CM.ROLL
    python utils/pipeline/fetch_report.py CM.AGED --period 01/26
    python utils/pipeline/fetch_report.py CM.ROLL --probe     # discover names
"""

import argparse
import re
import sys
from pathlib import Path

import pandas as pd

_PROJECT_ROOT = Path(__file__).resolve().parents[2]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))

from utils.config_util import Config
from utils.pipeline.pbi_client import (
    clean_columns, list_columns, list_measures, list_tables,
    parse_column_map, run_dax,
)

# Which config key holds the report export, per report section.
REPORT_OUTPUT_KEY = {
    "CM.ROLL": "ReportExcel",
    "CM.AGED": "ReportExcel",
    "CM.LEDGER": "ReportExcel",
}


def _substitute(dax: str, overrides: dict) -> str:
    """Replace ``__TOKEN__`` placeholders with filter values from config/CLI."""
    for key, value in overrides.items():
        if value is None:
            continue
        dax = dax.replace(f"__{key.upper()}__", str(value))
    leftover = re.findall(r"__([A-Z0-9_]+)__", dax)
    if leftover:
        raise ValueError(
            f"DAX still contains unresolved placeholders: {sorted(set(leftover))}. "
            f"Add matching keys to the [*.PBI] config section."
        )
    return dax


def _filter_overrides(cfg: Config, pbi_section: str, cli: dict) -> dict:
    """All non-structural keys in the *.PBI section become DAX placeholders."""
    structural = {"workspaceid", "datasetid", "daxquery", "columnmap", "sheetname"}
    overrides = {
        k: v for k, v in cfg.section_items(pbi_section).items()
        if k.lower() not in structural
    }
    overrides.update({k: v for k, v in cli.items() if v is not None})
    return overrides


def fetch_report(report: str,
                 cfg: Config | None = None,
                 output_path: str | Path | None = None,
                 **filter_overrides) -> Path:
    """Run the report's DAX query and save the result to its ReportExcel path.

    Parameters
    ----------
    report : str
        Config section name, e.g. ``"CM.ROLL"``.
    filter_overrides : dict
        Override any ``__TOKEN__`` in the DAX, e.g. ``period="01/26"``.
    """
    cfg = cfg or Config()
    pbi_section = f"{report}.PBI"

    if not cfg.has_section(pbi_section):
        raise KeyError(
            f"Config section [{pbi_section}] not found. "
            f"Add WorkspaceId / DatasetId / DaxQuery for '{report}'."
        )

    workspace_id = cfg.get_raw(pbi_section, "WorkspaceId")
    dataset_id = cfg.get_raw(pbi_section, "DatasetId")
    dax_template = cfg.get_raw(pbi_section, "DaxQuery")

    for name, value in (("WorkspaceId", workspace_id),
                        ("DatasetId", dataset_id),
                        ("DaxQuery", dax_template)):
        if not value or str(value).startswith("<"):
            raise ValueError(
                f"[{pbi_section}] {name} is not configured (value: {value!r})."
            )

    overrides = _filter_overrides(cfg, pbi_section, filter_overrides)
    dax = _substitute(dax_template, overrides)

    shown = {k: v for k, v in overrides.items()}
    print(f"[{report}] Running DAX  (filters: {shown})")

    df = run_dax(dax, workspace_id, dataset_id, cfg)
    print(f"[{report}] Retrieved {len(df)} rows")

    df = clean_columns(df, parse_column_map(cfg.get_raw(pbi_section, "ColumnMap")))
    print(f"[{report}] Columns: {list(df.columns)}")

    if output_path is None:
        out_key = REPORT_OUTPUT_KEY.get(report, "ReportExcel")
        output_path = cfg.get(report, out_key)
    out = Path(output_path)
    out.parent.mkdir(parents=True, exist_ok=True)

    sheet = cfg.get_raw(pbi_section, "SheetName", default="Sheet1") or "Sheet1"
    try:
        df.to_excel(out, index=False, sheet_name=sheet)
    except PermissionError:
        stamp = pd.Timestamp.now().strftime("%Y%m%d_%H%M%S")
        out = out.with_name(f"{out.stem}_{stamp}{out.suffix}")
        df.to_excel(out, index=False, sheet_name=sheet)
        print(f"[{report}] Target file was open; wrote fallback instead.")

    print(f"[{report}] Saved report export -> {out}")
    return out


def probe(report: str, cfg: Config | None = None) -> None:
    """Print dataset tables / measures / columns to help author the DAX."""
    cfg = cfg or Config()
    pbi_section = f"{report}.PBI"
    workspace_id = cfg.get_raw(pbi_section, "WorkspaceId")
    dataset_id = cfg.get_raw(pbi_section, "DatasetId")

    for label, fn in (("TABLES", list_tables),
                      ("MEASURES", list_measures),
                      ("COLUMNS", list_columns)):
        print(f"\n=============== {label} ===============")
        try:
            frame = fn(workspace_id, dataset_id, cfg)
            with pd.option_context("display.max_rows", 200,
                                   "display.max_colwidth", 60):
                print(frame.to_string(index=False))
        except Exception as exc:  # discovery is best-effort
            print(f"  (unavailable: {exc})")


def main() -> None:
    parser = argparse.ArgumentParser(description="Fetch a Power BI report via DAX.")
    parser.add_argument("report", help="Config section, e.g. CM.ROLL or CM.AGED")
    parser.add_argument("--period", help="Override the __PERIOD__ DAX placeholder")
    parser.add_argument("--out", help="Override the output Excel path")
    parser.add_argument("--probe", action="store_true",
                        help="List dataset tables/measures/columns and exit")
    args = parser.parse_args()

    if args.probe:
        probe(args.report)
        return

    fetch_report(args.report, output_path=args.out, period=args.period)


if __name__ == "__main__":
    main()

