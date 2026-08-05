import re
import sys
from pathlib import Path

import pandas as pd
import pdfplumber

# Allow running this file directly (python utils/BPG/RMAged.py).
_PROJECT_ROOT = Path(__file__).resolve().parents[2]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))

from utils.config_util import Config

# ===========================================
# CONFIG
# ===========================================

cfg = Config()

pdf_path = cfg.get(section="BPG", key="AgedPDF")
output_excel = cfg.get(section="BPG", key="AgedExcel")

# ===========================================
# EXTRACTION RULES
# ===========================================

NUMBER_TOKEN_RE = re.compile(r"\(?-?\d{1,3}(?:,\d{3})*(?:\.\d+)?\)?|\(?-?\d+(?:\.\d+)?\)?")
TOTAL_LINE_RE = re.compile(r"^(?P<name>.+?)\s+Total:\s*(?P<tail>.*)$", re.IGNORECASE)
# Skip non-occupant total lines when parsing occupant rows. Note the "Total:"
# is stripped from the captured name, so "Grand Total:" arrives here as "Grand".
SKIP_NAME_RE = re.compile(r"^(?:ENTITY\b|Grand\b|RMPROP\b)", re.IGNORECASE)

# Property-level total, e.g. "RMPROP 807000 Total: 20,949.52 -3,336.70 ...".
PROPERTY_TOTAL_RE = re.compile(
    r"^RMPROP\s+(?P<property_id>\d+)\s+Total:\s*(?P<tail>.*)$", re.IGNORECASE
)
# Property header, e.g. "Ascent at Metropolitan Naples (RMPROP: 807000)".
PROPERTY_HEADER_RE = re.compile(
    r"^(?P<name>.+?)\s*\(RMPROP:\s*(?P<property_id>\d+)\)\s*$", re.IGNORECASE
)
# Report grand total, e.g. "Grand Total: 16,847.41 -1,460.59 ...".
GRAND_TOTAL_RE = re.compile(r"^Grand\s+Total:\s*(?P<tail>.*)$", re.IGNORECASE)
# Example matches:
# - 207BH Adu-Afrane, Pius Applicant ...
# - 207BH-101IP-B3-1 Slifer, Juliana Occupy: ...
HEADER_LINE_RE = re.compile(
    r"^(?P<raw_id>[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*)\s+"
    r"(?P<name>.+?)"
    r"(?:\s+(?:Applicant\b|Occupy:|Last\s+Payment:|Times\s+Late:)|$)",
    re.IGNORECASE,
)


def normalize_name(name: str) -> str:
    return re.sub(r"[^a-z0-9]+", "", name.lower())


def format_display_name(name: str) -> str:
    """Convert a "Last, First" occupant name to "First Last".

    Example: "Romanos, Melissa" -> "Melissa Romanos". Names without a comma
    are returned unchanged (just whitespace-normalized).
    """
    if "," in name:
        last, first = name.split(",", 1)
        return f"{first.strip()} {last.strip()}".strip()
    return name.strip()


def parse_ids(raw_id: str) -> tuple[str, str, str]:
    """Split combined IDs into PropertyID, BuildingID, SuiteID.

    Rules:
    - If only one token (e.g. 207BH): PropertyID only.
    - If multiple tokens (e.g. 207BH-101IP-B3-1):
      first -> PropertyID, second -> BuildingID, remaining joined -> SuiteID.
    """
    parts = raw_id.split("-")
    property_id = parts[0]

    if len(parts) == 1:
        return property_id, "", ""

    building_id = parts[1]
    suite_id = "-".join(parts[2:]) if len(parts) > 2 else ""
    return property_id, building_id, suite_id


def to_float(raw: str) -> float:
    """Convert PDF number text like '(1,234.56)' or '-250.00' to float."""
    text = raw.strip().replace(",", "")
    if text.startswith("(") and text.endswith(")"):
        return -float(text[1:-1])
    return float(text)


def find_id_context(lines: list[str], row_idx: int, occupant_name: str) -> tuple[str, str, str, str]:
    """Find the nearest matching occupant header before a Total row."""
    target = normalize_name(occupant_name)
    fallback: tuple[str, str, str, str] = ("", "", "", "")

    # Search backwards to the previous "Total:" boundary (the end of the prior
    # occupant/property block). An occupant's charge detail can be long and may
    # span a page break, pushing the header far above its Total row
    # (e.g. "Tillis, Alan" is ~50 lines up), so a fixed-size window is not
    # enough. There is never another "Total:" line between a header and its own
    # Total, so stopping at the previous total keeps us within this block.
    for look_back in range(row_idx - 1, -1, -1):
        candidate = lines[look_back].strip()
        if not candidate:
            continue

        if "total:" in candidate.lower():
            break

        match = HEADER_LINE_RE.match(candidate)
        if not match:
            continue

        raw_id = match.group("raw_id").strip()
        # Ignore non-ID tokens like charge codes (APP, PPR, RRS).
        if not re.search(r"\d", raw_id):
            continue

        header_name = match.group("name").strip()
        property_id, building_id, suite_id = parse_ids(raw_id)
        record = (raw_id, property_id, building_id, suite_id)

        if fallback == ("", "", "", ""):
            fallback = record

        if normalize_name(header_name) == target:
            return record

    return fallback


def parse_total_row(lines: list[str], row_idx: int, line: str) -> dict | None:
    """Parse one occupant total row from current line and optional next lines."""
    match = TOTAL_LINE_RE.match(line)
    if not match:
        return None

    occupant_name = match.group("name").strip()
    if not occupant_name or SKIP_NAME_RE.match(occupant_name):
        return None

    values = [to_float(x) for x in NUMBER_TOKEN_RE.findall(match.group("tail"))]

    # Some PDFs split totals over the next line(s). Collect up to 6 values total.
    if len(values) < 6:
        for look_ahead in range(row_idx + 1, min(row_idx + 6, len(lines))):
            next_line = lines[look_ahead].strip()
            if not next_line:
                continue
            if "total:" in next_line.lower():
                break

            next_values = NUMBER_TOKEN_RE.findall(next_line)
            if not next_values:
                break

            values.extend(to_float(x) for x in next_values)
            if len(values) >= 6:
                break

    if len(values) < 6:
        return None

    raw_id, property_id, building_id, suite_id = find_id_context(lines, row_idx, occupant_name)

    return {
        "ID_Combined": raw_id,
        "PropertyID": property_id,
        "BuildingID": building_id,
        "SuiteID": suite_id,
        "OccupantName": occupant_name,
        "Normalized OccupantName": format_display_name(occupant_name),
        "Total": values[0],
        "Current": values[1],
        "Month_1": values[2],
        "Month_2": values[3],
        "Month_3": values[4],
        "Month_4": values[5],
    }


def read_pdf_lines(pdf_file: Path) -> tuple[list[str], list[int]]:
    """Read every page's text into one continuous list of lines.

    Returns the combined lines plus a parallel list holding each line's page
    number. Keeping all pages together lets the header/ID lookback in
    ``find_id_context`` cross page boundaries.
    """
    all_lines: list[str] = []
    line_pages: list[int] = []

    with pdfplumber.open(str(pdf_file)) as pdf:
        for page_no, page in enumerate(pdf.pages, start=1):
            text = page.extract_text() or ""
            for ln in text.splitlines():
                all_lines.append(ln.rstrip())
                line_pages.append(page_no)

    return all_lines, line_pages


def extract_occupant_totals(all_lines: list[str], line_pages: list[int]) -> pd.DataFrame:
    rows: list[dict] = []

    for idx, ln in enumerate(all_lines):
        parsed = parse_total_row(all_lines, idx, ln.strip())
        if parsed is None:
            continue
        parsed["Page"] = line_pages[idx]
        rows.append(parsed)

    df = pd.DataFrame(rows)
    if not df.empty:
        df = df.drop_duplicates(
            subset=[
                "ID_Combined",
                "OccupantName",
                "Total",
                "Current",
                "Month_1",
                "Month_2",
                "Month_3",
                "Month_4",
            ]
        ).reset_index(drop=True)

    return df


def extract_property_totals(all_lines: list[str], line_pages: list[int]) -> pd.DataFrame:
    """Extract property-level total rows (``RMPROP <id> Total: ...``).

    Property names are picked up from header lines such as
    ``Ascent at Metropolitan Naples (RMPROP: 807000)`` and mapped to their IDs.
    The report's closing ``Grand Total:`` line is included as a final row.
    """
    # Map each property ID to its display name from the header lines.
    property_names: dict[str, str] = {}
    for ln in all_lines:
        header = PROPERTY_HEADER_RE.match(ln.strip())
        if header:
            property_names.setdefault(
                header.group("property_id"), header.group("name").strip()
            )

    rows: list[dict] = []

    for idx, ln in enumerate(all_lines):
        stripped = ln.strip()

        prop = PROPERTY_TOTAL_RE.match(stripped)
        if prop:
            values = [to_float(x) for x in NUMBER_TOKEN_RE.findall(prop.group("tail"))]
            if len(values) < 6:
                continue
            property_id = prop.group("property_id")
            rows.append(
                {
                    "PropertyID": property_id,
                    "PropertyName": property_names.get(property_id, ""),
                    "Total": values[0],
                    "Current": values[1],
                    "Month_1": values[2],
                    "Month_2": values[3],
                    "Month_3": values[4],
                    "Month_4": values[5],
                    "Page": line_pages[idx],
                }
            )
            continue

        grand = GRAND_TOTAL_RE.match(stripped)
        if grand:
            values = [to_float(x) for x in NUMBER_TOKEN_RE.findall(grand.group("tail"))]
            if len(values) < 6:
                continue
            rows.append(
                {
                    "PropertyID": "",
                    "PropertyName": "Grand Total",
                    "Total": values[0],
                    "Current": values[1],
                    "Month_1": values[2],
                    "Month_2": values[3],
                    "Month_3": values[4],
                    "Month_4": values[5],
                    "Page": line_pages[idx],
                }
            )

    df = pd.DataFrame(rows)
    if not df.empty:
        df = df.drop_duplicates(
            subset=[
                "PropertyID",
                "PropertyName",
                "Total",
                "Current",
                "Month_1",
                "Month_2",
                "Month_3",
                "Month_4",
            ]
        ).reset_index(drop=True)

    return df


def main() -> None:
    print(f"PDF Source: {pdf_path}")
    all_lines, line_pages = read_pdf_lines(Path(pdf_path))

    occupant_df = extract_occupant_totals(all_lines, line_pages)
    property_df = extract_property_totals(all_lines, line_pages)

    if occupant_df.empty:
        print("No occupant totals found.")
    else:
        print(f"Extracted occupant totals: {len(occupant_df)}")
        print(occupant_df.head(10).to_string(index=False))

    if property_df.empty:
        print("No property totals found.")
    else:
        print(f"Extracted property totals: {len(property_df)}")
        print(property_df.to_string(index=False))

    with pd.ExcelWriter(output_excel, engine="openpyxl") as writer:
        occupant_df.to_excel(writer, sheet_name="Occupant Totals", index=False)
        property_df.to_excel(writer, sheet_name="Property Totals", index=False)

    print(f"Saved output to: {output_excel}")


if __name__ == "__main__":
    main()
