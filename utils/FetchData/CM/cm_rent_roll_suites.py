"""
PDF Rent Roll Extractor
"""

import sys
from pathlib import Path

_PROJECT_ROOT = Path(__file__).resolve().parents[3]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))

import re
import fitz
import pandas as pd
from utils.config_util import Config

# ---------- CONFIG ----------
cfg = Config()
pdf_path = cfg.get("CM.ROLL", "PDF")
output_excel = cfg.get("CM.ROLL", "ExtractedSuites")

debug_file = str(output_excel).replace(".xlsx", "_DEBUG.txt")

print(f"Reading PDF: {pdf_path}")
print(f"Saving to: {output_excel}")
print(f"Debug file: {debug_file}\n")


# ---------- HELPERS ----------

def is_new_row(line):
    return bool(re.match(r'^\d{3}[A-Z]\d{2}\b', line))


def is_noise(line):
    return bool(re.match(r'^(C\d+|GST|T\d+|R\d+|FIT)', line))


def clean_numeric(val):
    if not val:
        return None
    val = val.replace(",", "").replace("(", "-").replace(")", "")
    try:
        return float(val)
    except:
        return None


def clean_text(text):
    text = re.sub(r'([a-zA-Z])(\d{1,2}/\d{1,2}/\d{4})', r'\1 \2', text)
    text = re.sub(r'(\d{4})([A-Za-z])', r'\1 \2', text)
    return text


# ---------- EXTRACT TEXT ----------

doc = fitz.open(pdf_path)
full_text = ""

for page in doc:
    full_text += page.get_text("text") + "\n"

lines = full_text.split("\n")


# ---------- BUILD ROWS WITH STATUS ----------

rows = []
current = ""
current_status = "Unknown"

for line in lines:
    line = line.strip()

    if not line:
        continue

    # STATUS DETECTION
    if "Occupied Units" in line:
        current_status = "Occupied"
        continue
    elif "Vacant Units" in line:
        current_status = "Vacant"
        continue
    elif "New Leases" in line:
        current_status = "New"
        continue
    elif "Excluded" in line:
        current_status = "Excluded"
        continue

    # Skip headers
    if any(x in line for x in ["Database:", "Page:", "Rent Roll"]):
        continue

    # Skip noise
    if is_noise(line):
        continue

    # Build rows
    if is_new_row(line):
        if current:
            rows.append((current, current_status))
        current = line
    else:
        if current:
            current += " " + line

if current:
    rows.append((current, current_status))

print(f"Rows built: {len(rows)}")


# ---------- PARSE UNIT ROWS (WITH DEBUG) ----------

unit_records = []
debug_rows = []

for idx, (row, status) in enumerate(rows):

    original_row = row

    try:
        row = clean_text(row)
        tokens = row.split()

        debug_info = {
            "Row Index": idx,
            "Raw Row": original_row,
            "Cleaned Row": row,
            "Tokens": str(tokens),
            "Status": status
        }

        if len(tokens) < 2:
            debug_info["Error"] = "Too few tokens"
            debug_rows.append(debug_info)
            continue

        building_id = tokens[0]
        second_token = tokens[1]

        # ---------- SUITE ----------
        if second_token.lower() == "vacant":
            suite_id = ""
            occupant = "N/A"
            is_vacant = True
        else:
            suite_id = second_token
            is_vacant = False

        # ---------- DATES ----------
        date_matches = list(re.finditer(r'\d{1,2}/\d{1,2}/\d{4}', row))
        rent_start = date_matches[0].group() if len(date_matches) > 0 else ""
        expiration = date_matches[1].group() if len(date_matches) > 1 else ""

        # ---------- OCCUPANT ----------
        if not is_vacant:
            if date_matches:
                first_date_pos = date_matches[0].start()
                prefix = row[:first_date_pos]

                prefix = prefix.replace(building_id, "", 1)
                prefix = prefix.replace(suite_id, "", 1)

                occupant = prefix.strip()
            else:
                occupant = " ".join(tokens[2:])
        else:
            occupant = "N/A"

        # ---------- NUMERIC ----------
        nums = re.findall(r'[-\d,]+\.\d+', row)
        nums = [clean_numeric(n) for n in nums]

        # ---------- DEBUG FLAGS ----------
        debug_info.update({
            "Building ID": building_id,
            "Suite ID": suite_id,
            "Occupant": occupant,
            "Dates": [m.group() for m in date_matches],
            "Numbers": nums
        })

        if not suite_id:
            debug_info["Warning"] = "Missing Suite ID"
        elif len(occupant) < 3:
            debug_info["Warning"] = "Short Occupant"
        elif any(char.isdigit() for char in occupant):
            debug_info["Warning"] = "Occupant has numbers"

        debug_rows.append(debug_info)

        # ---------- FINAL ----------
        unit_records.append({
            "Building ID": building_id,
            "Suite ID": suite_id,
            "Occupant Name": occupant,
            "Rent Start": rent_start,
            "Expiration": expiration,
            "GLA Sqft": nums[0] if len(nums) > 0 else None,
            "Monthly Base Rent": nums[1] if len(nums) > 1 else None,
            "Annual Rate PSF": nums[2] if len(nums) > 2 else None,
            "Status": status
        })

    except Exception as e:
        debug_rows.append({
            "Row Index": idx,
            "Raw Row": original_row,
            "Error": str(e)
        })


# ---------- TOTALS ----------

total_records = []
capturing = False
buffer = []
current_building_id = "Unknown"

for line in lines:
    line = line.strip()

    if is_new_row(line):
        current_building_id = line.split()[0]

    if "Totals:" in line or "Grand Total" in line:
        capturing = True
        buffer = [line]
        continue

    if capturing:
        buffer.append(line)

        if line == "" or is_new_row(line):
            text = " ".join(buffer)

            nums = re.findall(r'[-\d,]+\.\d+', text)
            nums = [clean_numeric(n) for n in nums]

            perc = re.search(r'\d+\.\d+%', text)

            total_records.append({
                "Building ID": current_building_id,
                "Type": "Grand Total" if "Grand" in text else "Building Total",
                "Percentage": perc.group(0) if perc else "",
                "Square Feet": nums[0] if len(nums) > 0 else None,
                "Monthly Base Rent": nums[1] if len(nums) > 1 else None,
                "Monthly Cost Recovery": nums[2] if len(nums) > 2 else None,
                "Monthly Other Income": nums[3] if len(nums) > 3 else None,
            })

            capturing = False
            buffer = []


# ---------- DATAFRAMES ----------

df_units = pd.DataFrame(unit_records)
df_totals = pd.DataFrame(total_records)
df_debug = pd.DataFrame(debug_rows)

print(f"\nUnits Extracted: {len(df_units)}")
print(f"Totals Extracted: {len(df_totals)}\n")


# ---------- OUTPUT ----------

with pd.ExcelWriter(output_excel, engine="openpyxl") as writer:

    if not df_units.empty:
        df_units.to_excel(writer, sheet_name="Unit Level", index=False)

    if not df_totals.empty:
        df_totals.to_excel(writer, sheet_name="Property Totals", index=False)

    df_debug.to_excel(writer, sheet_name="DEBUG", index=False)

# Write debug text
with open(debug_file, "w", encoding="utf-8") as f:
    for d in debug_rows:
        f.write(str(d) + "\n\n")

print(f"Saved to: {output_excel}")
print(f"Debug saved to: {debug_file}")