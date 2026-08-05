import pdfplumber
import pandas as pd
import re
import sys
from pathlib import Path

# Allow running this file directly (python utils/BPG/DetRentRoll.py).
_PROJECT_ROOT = Path(__file__).resolve().parents[2]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))

from utils.config_util import Config

# ===========================================
# CONFIG
# ===========================================

cfg = Config()

pdf_path = cfg.get(section="BPG", key="DetRollPDF")
output_excel = cfg.get(section="BPG", key="DetRollExcel")

# ===========================================
# COLUMN GEOMETRY (derived from the report header word positions)
# All values are horizontal (x) coordinates in PDF points.
# ===========================================

# Left-hand text columns -> (x_low, x_high) for character-center slicing
UNIT_X = (36, 66)
PLAN_X = (66, 101)
BUILDING_X = (101, 141)
SQFT_X = (141, 171)
STATUS_X = (171, 215)
NAME_X = (215, 373)          # letters only (dates are filtered out by digit test)
OCCUPY_X = (283, 329)        # digits/slash only
LSTART_X = (329, 373)
LEND_X = (373, 462)

# Money columns are right-aligned. Because large values can visually touch
# (e.g. "471,329.60333,715.35"), we slice by fixed x-windows per column so
# adjacent numbers are always separated cleanly.
MONEY_WINDOWS = [
    ("MarketRent", 462, 512),
    ("LeaseRent", 512, 576),
    ("RentConcessions", 576, 630),
    ("TotalBilling", 630, 675),
    ("DepositOnHand", 675, 716),
    ("Balance", 716, 782),
]
MONEY_CHARS = set("0123456789(),.-")

NUM_TOKEN_RE = re.compile(r"^\(?-?[\d,]+(?:\.\d+)?\)?$")
DATE_RE = re.compile(r"\d{1,2}/\d{1,2}/\d{4}")
PROP_HEADER_RE = re.compile(r"^(?P<name>.*?)\((?P<pid>[0-9A-Za-z]+)\)Period:")
NAME_KEEP = set(",'.&- ")


# ===========================================
# HELPERS
# ===========================================

def to_money(text):
    """'1,675.00' -> 1675.0 ; '(195.00)' -> -195.0"""
    if not text:
        return None
    t = text.strip()
    neg = t.startswith("(") and t.endswith(")")
    t = t.strip("()").replace(",", "")
    try:
        val = float(t)
    except ValueError:
        return None
    return -val if neg else val


def cluster_lines(chars, y_tol=3.0):
    """Group characters into visual lines by their top coordinate."""
    lines = []
    for c in sorted(chars, key=lambda c: (round(c["top"], 1), c["x0"])):
        if lines and abs(c["top"] - lines[-1]["top"]) <= y_tol:
            lines[-1]["chars"].append(c)
        else:
            lines.append({"top": c["top"], "chars": [c]})
    for ln in lines:
        ln["chars"].sort(key=lambda c: c["x0"])
    return lines


def joined_text(line_chars):
    """All characters concatenated in x-order (no spaces)."""
    return "".join(c["text"] for c in line_chars)


def slice_col(line_chars, x_range, keep):
    lo, hi = x_range
    out = []
    for c in line_chars:
        xc = (c["x0"] + c["x1"]) / 2.0
        if lo <= xc < hi and keep(c["text"]):
            out.append(c)
    out.sort(key=lambda c: c["x0"])
    return "".join(c["text"] for c in out).strip()


def text_col(line_chars, x_range):
    return slice_col(line_chars, x_range, lambda ch: not ch.isspace())


def name_col(line_chars):
    raw = slice_col(
        line_chars,
        NAME_X,
        lambda ch: ch.isalpha() or ch in NAME_KEEP,
    )
    return re.sub(r"\s+", " ", raw).strip(" ,")


def normalize_name(name):
    """'Staudle,Megan' -> 'Megan Staudle' (Last,First -> First Last)."""
    if not name:
        return ""
    if "," in name:
        last, first = name.split(",", 1)
        first = first.strip()
        last = last.strip()
        return f"{first} {last}".strip()
    return name.strip()


def date_col(line_chars, x_range):
    raw = slice_col(line_chars, x_range, lambda ch: ch.isdigit() or ch == "/")
    m = DATE_RE.search(raw)
    return m.group(0) if m else ""


def line_tokens(line_chars, gap=2.0):
    """Split a line's characters into tokens separated by horizontal gaps."""
    tokens = []
    cur = []
    for c in line_chars:
        if cur and (c["x0"] - cur[-1]["x1"]) > gap:
            tokens.append(cur)
            cur = []
        cur.append(c)
    if cur:
        tokens.append(cur)
    return [
        {
            "text": "".join(t["text"] for t in tk),
            "x0": tk[0]["x0"],
            "x1": tk[-1]["x1"],
        }
        for tk in tokens
    ]


def money_on_line(line_chars):
    """Return {column: value} by slicing the money region into fixed x-windows."""
    result = {}
    for key, lo, hi in MONEY_WINDOWS:
        cs = [
            c for c in line_chars
            if lo <= (c["x0"] + c["x1"]) / 2.0 < hi and c["text"] in MONEY_CHARS
        ]
        cs.sort(key=lambda c: c["x0"])
        s = "".join(c["text"] for c in cs)
        val = to_money(s) if s else None
        if val is not None:
            result[key] = val
    return result


def numeric_tokens(line_chars):
    """All numeric tokens on a line, in x-order (ints and decimals)."""
    return [
        to_money(tok["text"])
        for tok in line_tokens(line_chars)
        if NUM_TOKEN_RE.match(tok["text"])
    ]


def line_text_spaced(line_chars, gap=2.0):
    """Readable line text reconstructed from visual tokens."""
    parts = [tok["text"] for tok in line_tokens(line_chars, gap=gap)]
    return " ".join(parts).strip()


def is_rnt_rent_line(line_chars):
    """True only for the RNT Rent charge sub-line."""
    spaced = line_text_spaced(line_chars)
    if re.search(r"\bRNT\b.*\bRent\b", spaced, flags=re.IGNORECASE):
        return True

    # Fallback for PDFs where spacing collapses into a single token.
    compact = re.sub(r"\s+", "", spaced).upper()
    return "RNTRENT" in compact


def is_charge_subline(line_chars):
    """Detect likely charge sub-lines under a unit row."""
    spaced = line_text_spaced(line_chars)
    return bool(re.search(r"\b(?:RNT|PKG|STO|PPS|GAR|PRK|PARK)\b", spaced, flags=re.IGNORECASE))


# ===========================================
# MAIN PARSER
# ===========================================

def parse_pdf(pdf_file):
    units = []                 # main rent-roll rows
    building_totals = []       # "Total for Building"
    property_totals = []       # "Total for Property"
    property_summaries = []    # floor-plan "Totals/Averages"
    lease_rent_warnings = []   # units with sub-lines but unresolved RNT lease rent

    property_id = None
    property_name = None
    property_names = {}        # id -> friendly name
    last_completed_property = None
    current_unit = None

    def finalize_unit():
        nonlocal current_unit
        if current_unit:
            saw_charge = bool(current_unit.pop("_saw_charge_subline", False))
            saw_rnt = bool(current_unit.pop("_saw_rnt_rent", False))
            lease_val = current_unit.get("Lease Rent")
            if saw_charge and (not saw_rnt) and lease_val in (None, 0.0):
                lease_rent_warnings.append({
                    "Property": current_unit.get("Property"),
                    "Building": current_unit.get("Building"),
                    "Unit": current_unit.get("Unit"),
                    "Name": current_unit.get("Name"),
                    "Issue": "Charge sub-lines found but no RNT Rent line detected; Lease Rent unresolved",
                })
            units.append(current_unit)
            current_unit = None

    with pdfplumber.open(str(pdf_file)) as pdf:
        for page in pdf.pages:
            for line in cluster_lines(page.chars):
                chars = line["chars"]
                jt = joined_text(chars)

                # --- Total for Property -------------------------------------
                if jt.startswith("TotalforProperty"):
                    finalize_unit()
                    m = re.match(r"TotalforProperty:([0-9A-Za-z]+)-([^0-9(]+)", jt)
                    pid = m.group(1) if m else property_id
                    pname = m.group(2).strip() if m else property_name
                    if pid and pname:
                        property_names.setdefault(pid, pname)
                    money = money_on_line(chars)
                    property_totals.append({
                        "Property": pid,
                        "Property Name": property_names.get(pid, pname),
                        "Market Rent": money.get("MarketRent"),
                        "Lease Rent": money.get("LeaseRent"),
                        "Rent Concessions": money.get("RentConcessions"),
                        "Total Billing": money.get("TotalBilling"),
                        "Deposit On Hand": money.get("DepositOnHand"),
                        "Balance": money.get("Balance"),
                    })
                    last_completed_property = pid
                    continue

                # --- Total for Building -------------------------------------
                if jt.startswith("TotalforBuilding"):
                    finalize_unit()
                    m = re.match(r"TotalforBuilding:([0-9A-Za-z]+)", jt)
                    bid = m.group(1) if m else ""
                    money = money_on_line(chars)
                    building_totals.append({
                        "Property": property_id,
                        "Building": bid,
                        "Market Rent": money.get("MarketRent"),
                        "Lease Rent": money.get("LeaseRent"),
                        "Rent Concessions": money.get("RentConcessions"),
                        "Total Billing": money.get("TotalBilling"),
                        "Deposit On Hand": money.get("DepositOnHand"),
                        "Balance": money.get("Balance"),
                    })
                    continue

                # --- Floor-plan Totals/Averages (per property) --------------
                if jt.startswith("Totals/Averages"):
                    finalize_unit()
                    nums = numeric_tokens(chars)
                    pid = last_completed_property or property_id
                    row = {
                        "Property": pid,
                        "Property Name": property_names.get(pid),
                    }
                    labels = [
                        "# of Units", "Avg SqFt", "Avg Market Rent",
                        "Market Amt/SqFt", "Avg Leased Rent", "Leased Amt/SqFt",
                        "Units Occupied", "Occupancy %", "Units Available",
                    ]
                    for i, lab in enumerate(labels):
                        row[lab] = nums[i] if i < len(nums) else None
                    property_summaries.append(row)
                    continue

                # --- Property header ----------------------------------------
                ph = PROP_HEADER_RE.match(jt)
                if ph:
                    finalize_unit()
                    property_id = ph.group("pid")
                    property_name = ph.group("name").strip()
                    property_names.setdefault(property_id, property_name)
                    continue

                # --- Unit (lease) data row ----------------------------------
                unit = text_col(chars, UNIT_X)
                occupy = date_col(chars, OCCUPY_X)
                status = text_col(chars, STATUS_X)
                if unit and occupy and status:
                    finalize_unit()
                    money = money_on_line(chars)
                    parsed_name = name_col(chars)
                    current_unit = {
                        "Property": property_id,
                        "Unit": unit,
                        "Floor Plan": text_col(chars, PLAN_X),
                        "Building": text_col(chars, BUILDING_X),
                        "Unit/Lease Status": status,
                        "Name": parsed_name,
                        "Normalized Name": normalize_name(parsed_name),
                        "Occupy Date": occupy,
                        "Lease Start Date": date_col(chars, LSTART_X),
                        "Lease End Date": date_col(chars, LEND_X),
                        "Market Rent": money.get("MarketRent"),
                        "Lease Rent": money.get("LeaseRent"),
                        "Total Billing": money.get("TotalBilling"),
                        "Deposit On Hand": money.get("DepositOnHand"),
                        "Balance": money.get("Balance"),
                        "_saw_charge_subline": False,
                        "_saw_rnt_rent": False,
                    }
                    continue

                # --- Charge sub-line: Lease Rent must come from RNT Rent only -----
                # Ignore other sub-lines like PKG Parking, STO Storage, etc.
                if current_unit and current_unit.get("Lease Rent") in (None, 0.0):
                    if is_charge_subline(chars):
                        current_unit["_saw_charge_subline"] = True
                    if is_rnt_rent_line(chars):
                        current_unit["_saw_rnt_rent"] = True
                        money = money_on_line(chars)
                        lease = money.get("LeaseRent")
                        if lease is not None:
                            current_unit["Lease Rent"] = lease

        finalize_unit()

    return {
        "units": units,
        "building_totals": building_totals,
        "property_totals": property_totals,
        "property_summaries": property_summaries,
        "lease_rent_warnings": lease_rent_warnings,
    }


def main():
    pdf_file = Path(pdf_path)
    print(f"PDF Source: {pdf_file}")
    if not pdf_file.exists():
        raise FileNotFoundError(f"PDF not found: {pdf_file}")

    data = parse_pdf(pdf_file)

    unit_cols = [
        "Property", "Unit", "Floor Plan", "Building", "Unit/Lease Status",
        "Name", "Normalized Name", "Occupy Date", "Lease Start Date", "Lease End Date",
        "Market Rent", "Lease Rent", "Total Billing", "Deposit On Hand", "Balance",
    ]
    df_units = pd.DataFrame(data["units"], columns=unit_cols)
    df_summary = pd.DataFrame(data["property_summaries"])
    df_building = pd.DataFrame(data["building_totals"])
    df_property = pd.DataFrame(data["property_totals"])
    df_warnings = pd.DataFrame(data.get("lease_rent_warnings", []))

    print(f"  Lease rows        : {len(df_units)}")
    print(f"  Building totals   : {len(df_building)}")
    print(f"  Property totals   : {len(df_property)}")
    print(f"  Property summaries: {len(df_summary)}")
    print(f"  Lease rent warnings: {len(df_warnings)}")

    out = Path(output_excel)
    out.parent.mkdir(parents=True, exist_ok=True)

    def write_workbook(target: Path) -> None:
        with pd.ExcelWriter(target, engine="openpyxl") as writer:
            df_units.to_excel(writer, sheet_name="Rent Roll", index=False)
            df_summary.to_excel(writer, sheet_name="Totals-Averages by Property", index=False)
            df_building.to_excel(writer, sheet_name="Total for Building", index=False)
            df_property.to_excel(writer, sheet_name="Total for Property", index=False)
            if not df_warnings.empty:
                df_warnings.to_excel(writer, sheet_name="Lease Rent Warnings", index=False)

    try:
        write_workbook(out)
        print(f"Saved output to: {out}")
    except PermissionError:
        ts = pd.Timestamp.now().strftime("%Y%m%d_%H%M%S")
        fallback = out.with_name(f"{out.stem}_{ts}{out.suffix}")
        write_workbook(fallback)
        print(f"Primary file is open; saved to fallback: {fallback}")

    if not df_units.empty:
        print("\nSample rent-roll rows:")
        print(df_units.head(8).to_string(index=False))

    if not df_warnings.empty:
        print("\nLease rent warnings (first 10):")
        print(df_warnings.head(10).to_string(index=False))


if __name__ == "__main__":
    main()

