import pdfplumber
import pandas as pd
import re

from utils.config_util import Config

# ===========================================
# CONFIG
# ===========================================

cfg = Config()

pdf_path = cfg.get(
    section="BPG",
    key="RollPDF"
)

output_excel = cfg.get(
    section="BPG",
    key="RollExcel"
)

# ===========================================
# Patterns
# ===========================================

property_pattern = re.compile(
    r"Property:\s*([A-Za-z0-9\-]+).*?\n([^\n]+)",
    re.IGNORECASE
)

building_pattern = re.compile(
    r"Building:\s*([A-Za-z0-9\-]+)",
    re.IGNORECASE
)

property_title_pattern = re.compile(
    r"^\s*(.*?)\s*\(([A-Za-z0-9\-]+)\)\s*$"
)

property_totals_line_pattern = re.compile(
    r"^\s*PropertyTotals\s+([A-Za-z0-9\-]+)\s+(.+?)\s*$",
    re.IGNORECASE,
)

units_pct_patterns = {
    "Occupied": re.compile(r"Occupied\s+([\d,]+)\s+(\d+\.\d+%)", re.IGNORECASE),
    "Special Use": re.compile(r"SpecialUse\s+([\d,]+)\s+(\d+\.\d+%)", re.IGNORECASE),
    "New Construction": re.compile(r"NewConstruction\s+([\d,]+)\s+(\d+\.\d+%)", re.IGNORECASE),
    "Vacant": re.compile(r"Vacant\s+([\d,]+)\s+(\d+\.\d+%)", re.IGNORECASE),
}

total_units_pattern = re.compile(r"TotalUnits\s+([\d,]+)", re.IGNORECASE)

# ===========================================
# Helpers
# ===========================================


def to_int(value):
    cleaned = value.replace(",", "").replace("%", "")
    return int(float(cleaned))


def parse_occupancy_totals(lines, start_idx, next_lines=None):
    # Totals rows are directly after SecurityTotals and may span OCR-compacted lines.
    next_lines = next_lines or []
    merged_lines = lines[start_idx:start_idx + 16] + next_lines[:16]
    window = " ".join(merged_lines)

    extracted = {}
    for label, pattern in units_pct_patterns.items():
        match = pattern.search(window)
        if not match:
            return None
        extracted[label] = (to_int(match.group(1)), match.group(2))

    total_match = total_units_pattern.search(window)
    if not total_match:
        return None

    total_units = to_int(total_match.group(1))

    return {
        "Total Units": total_units,
        "Occupied Units": extracted["Occupied"][0],
        "Special Use": extracted["Special Use"][0],
        "New Construction": extracted["New Construction"][0],
        "Vacant": extracted["Vacant"][0],
        "Occupied %": extracted["Occupied"][1],
        "Special Use %": extracted["Special Use"][1],
        "New Construction %": extracted["New Construction"][1],
        "Vacant %": extracted["Vacant"][1],
    }


def building_from_line(line):
    match = re.search(r"^\s*([A-Za-z0-9\-]+)\s+Building\s+Totals?", line, re.IGNORECASE)
    if match:
        return match.group(1).strip()
    return ""

# ===========================================
# Results
# ===========================================

property_rows = []
building_rows = []

current_property = ""
current_property_name = ""
current_building = "PROPERTY TOTAL"
pending_property_total = False
pending_building_total = False

# ===========================================
# Read PDF
# ===========================================

with pdfplumber.open(pdf_path) as pdf:

    for page_index in range(len(pdf.pages)):
        page_no = page_index + 1
        page = pdf.pages[page_index]

        text = page.extract_text()

        if not text:
            continue

        lines = text.splitlines()
        next_text = ""
        if page_index + 1 < len(pdf.pages):
            next_text = pdf.pages[page_index + 1].extract_text() or ""
        next_lines = next_text.splitlines()

        # -----------------------------------
        # Property
        # -----------------------------------

        prop = property_pattern.search(text)

        if prop:
            current_property = prop.group(1).strip()
            current_property_name = re.sub(r"\s+Time:.*$", "", prop.group(2).strip(), flags=re.IGNORECASE)
        elif lines:
            # Fallback format: Property Name (PROPERTY_CODE)
            title_match = property_title_pattern.match(lines[0])
            if title_match:
                current_property_name = title_match.group(1).strip()
                current_property = title_match.group(2).strip()

        # -----------------------------------
        # Building
        # -----------------------------------

        bld = building_pattern.search(text)

        if bld:
            current_building = bld.group(1).strip()

        # -----------------------------------
        # Totals blocks (marker -> SecurityTotals)
        # -----------------------------------

        for i, line in enumerate(lines):
            prop_totals_match = property_totals_line_pattern.search(line)
            if prop_totals_match:
                current_property = prop_totals_match.group(1).strip()
                current_property_name = prop_totals_match.group(2).strip()
                pending_property_total = True
                pending_building_total = False
                continue

            if "BuildingTotals" in line:
                pending_building_total = True
                pending_property_total = False
                continue

            bld_line = building_pattern.search(line)
            if bld_line:
                current_building = bld_line.group(1).strip()

            if "SecurityTotals" not in line:
                continue

            totals = parse_occupancy_totals(lines, i, next_lines)
            if not totals:
                continue

            if pending_property_total:
                property_rows.append({
                    "Property Code": current_property,
                    "Property Name": current_property_name,
                    **totals,
                })
                pending_property_total = False
                continue

            if pending_building_total:
                building_rows.append({
                    "Property Code": current_property,
                    "Building": current_building,
                    **totals,
                })
                pending_building_total = False

# ===========================================
# Export
# ===========================================

property_columns = [
    "Property Code",
    "Property Name",
    "Total Units",
    "Occupied Units",
    "Special Use",
    "New Construction",
    "Vacant",
    "Occupied %",
    "Special Use %",
    "New Construction %",
    "Vacant %",
]

building_columns = [
    "Property Code",
    "Building",
    "Total Units",
    "Occupied Units",
    "Special Use",
    "New Construction",
    "Vacant",
    "Occupied %",
    "Special Use %",
    "New Construction %",
    "Vacant %",
]

property_df = pd.DataFrame(property_rows)
building_df = pd.DataFrame(building_rows)

if not property_df.empty:
    property_df = property_df[property_columns]

if not building_df.empty:
    building_df = building_df[building_columns]

with pd.ExcelWriter(output_excel, engine="openpyxl") as writer:
    property_df.to_excel(writer, sheet_name="Property Totals", index=False)
    building_df.to_excel(writer, sheet_name="Building Totals", index=False)

print(f"Property Total Rows Extracted : {len(property_df)}")
print(f"Building Total Rows Extracted : {len(building_df)}")
print(f"Output : {output_excel}")