"""Adapters around the existing hand-written PDF parsers.

Some reports use extraction techniques the declarative engine cannot express -
PDF coordinate slicing, content-stream reconstruction, multi-page backward
lookback. Rewriting them as regex specs would lose accuracy, so instead the
proven parsers are reused as-is and wrapped here.

Each adapter takes ``(pdf_path, cfg)`` and returns a ``DataFrame``. The pipeline
then layers validation, drift detection, baselines, comparison and the
Needs-Review report on top - the legacy modules are never modified.

Referenced from a schema via::

    "mode": "custom",
    "source": { "handler": "utils.pipeline.adapters:cm_roll_dolben" }
"""

import importlib
import sys
from pathlib import Path

import pandas as pd

_PROJECT_ROOT = Path(__file__).resolve().parents[2]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))


class AdapterError(RuntimeError):
    """Raised when a custom handler cannot be resolved or run."""


def resolve_handler(dotted: str):
    """Resolve ``"package.module:function"`` into a callable."""
    if not dotted or ":" not in dotted:
        raise AdapterError(
            f"Invalid handler {dotted!r}. Expected 'module.path:function'.")
    module_name, func_name = dotted.split(":", 1)
    try:
        module = importlib.import_module(module_name)
    except ImportError as exc:
        raise AdapterError(f"Cannot import '{module_name}': {exc}") from exc
    handler = getattr(module, func_name, None)
    if handler is None or not callable(handler):
        raise AdapterError(f"'{module_name}' has no callable '{func_name}'.")
    return handler


def _ensure_columns(df: pd.DataFrame, columns: list) -> pd.DataFrame:
    for col in columns:
        if col not in df.columns:
            df[col] = None
    return df


# ---------------------------------------------------------------------------
# Dolben - CM Rent Roll  (utils/Dolben/CMRoll.py)
# Uses pdfplumber character positions + content-stream ordering to rebuild
# lines, because occupant names overlap the date/number columns in this PDF.
# ---------------------------------------------------------------------------
def cm_roll_dolben(pdf_path, cfg) -> pd.DataFrame:
    from utils.Dolben.CMRoll import parse_pdf

    df_suites, _totals_wide, _totals_detail = parse_pdf(Path(pdf_path))
    if df_suites is None or df_suites.empty:
        return pd.DataFrame()

    columns = [
        "Building ID", "Suite ID", "Occupant Name", "Rent Start", "Expiration",
        "GLA Sqft", "Monthly Base Rent", "Annual Rate PSF",
        "Monthly Cost Recovery", "Monthly Other Income", "Section",
    ]
    return _ensure_columns(df_suites.copy(), columns)[columns]


def cm_roll_dolben_totals(pdf_path, cfg) -> pd.DataFrame:
    """Building-level totals from the same Dolben parse."""
    from utils.Dolben.CMRoll import parse_pdf

    _suites, totals_wide, _detail = parse_pdf(Path(pdf_path))
    return totals_wide if totals_wide is not None else pd.DataFrame()


# ---------------------------------------------------------------------------
# BPG - RM Aged Delinquency  (utils/BPG/RMAged.py)
# Needs a backward lookback across page breaks to bind an occupant total row
# to the header that carries its Property/Building/Suite IDs.
# ---------------------------------------------------------------------------
def rm_aged_occupants(pdf_path, cfg) -> pd.DataFrame:
    from utils.BPG.RMAged import extract_occupant_totals, read_pdf_lines

    lines, pages = read_pdf_lines(Path(pdf_path))
    df = extract_occupant_totals(lines, pages)
    if df is None or df.empty:
        return pd.DataFrame()

    columns = [
        "ID_Combined", "PropertyID", "BuildingID", "SuiteID",
        "OccupantName", "Normalized OccupantName",
        "Total", "Current", "Month_1", "Month_2", "Month_3", "Month_4", "Page",
    ]
    return _ensure_columns(df.copy(), columns)[columns]


def rm_aged_properties(pdf_path, cfg) -> pd.DataFrame:
    from utils.BPG.RMAged import extract_property_totals, read_pdf_lines

    lines, pages = read_pdf_lines(Path(pdf_path))
    df = extract_property_totals(lines, pages)
    return df if df is not None else pd.DataFrame()


# ---------------------------------------------------------------------------
# BPG - Detailed Rent Roll  (utils/BPG/DetRentRoll.py)
# Slices fixed x-coordinate windows so adjacent right-aligned money columns
# ("471,329.60333,715.35") always separate cleanly.
# ---------------------------------------------------------------------------
def det_rent_roll_units(pdf_path, cfg) -> pd.DataFrame:
    from utils.BPG.DetRentRoll import parse_pdf

    data = parse_pdf(Path(pdf_path))
    df = pd.DataFrame(data.get("units", []))
    if df.empty:
        return df

    columns = [
        "Property", "Unit", "Floor Plan", "Building", "Unit/Lease Status",
        "Name", "Normalized Name", "Occupy Date", "Lease Start Date",
        "Lease End Date", "Market Rent", "Lease Rent", "Total Billing",
        "Deposit On Hand", "Balance",
    ]
    return _ensure_columns(df, columns)[columns]


def det_rent_roll_property_totals(pdf_path, cfg) -> pd.DataFrame:
    from utils.BPG.DetRentRoll import parse_pdf

    data = parse_pdf(Path(pdf_path))
    return pd.DataFrame(data.get("property_totals", []))


# ---------------------------------------------------------------------------
# BPG - Property Status Report  (utils/BPG/PropertyStatusReport.py)
# ---------------------------------------------------------------------------
def property_status(pdf_path, cfg) -> pd.DataFrame:
    from utils.BPG.PropertyStatusReport import extract_property_status

    df = extract_property_status(Path(pdf_path))
    if df is None or df.empty:
        return pd.DataFrame()

    columns = [
        "Property Code", "Property Name", "Avg Sqft", "Avg Market",
        "Avg $/Sqft", "Total Units", "Total Leased", "Total Available",
        "Total Other", "Occupancy %", "Move Ins", "Move Outs",
        "Turn Over", "Notice Given",
    ]
    return _ensure_columns(df.copy(), columns)[columns]

