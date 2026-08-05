import re
import pandas as pd
from utils.config_util import Config

# ---------- CONFIG ----------
cfg = Config()
text_file = cfg.get("CM.ROLL", "TXT")
output_excel = cfg.get("CM.ROLL", "ExtractedSuites")


print(f"Reading PDF: {text_file}")
print(f"Saving to: {output_excel}")


# ---------- HELPERS ----------

def is_unit_row(line):
    return bool(re.match(r'^\d{3}[A-Z]\d{2}\s+\S+', line))


def is_noise(line):
    return bool(re.match(r'^(C\d+|GST|T\d+|R\d+|FIT)', line))


def clean_num(x):
    if not x:
        return None
    return float(x.replace(",", ""))


# ---------- READ FILE ----------

with open(text_file, "r", encoding="utf-8") as f:
    lines = [l.strip() for l in f.readlines() if l.strip()]


# ---------- STATE ----------

current_status = "Unknown"
current_building = "Unknown"
records = []
totals = []

i = 0
while i < len(lines):

    line = lines[i]

    # ---------- STATUS ----------
    if "Occupied Units" in line:
        current_status = "Occupied"
        i += 1
        continue
    elif "Vacant Units" in line:
        current_status = "Vacant"
        i += 1
        continue
    elif "New Leases" in line:
        current_status = "New"
        i += 1
        continue
    elif "Excluded Units" in line:
        current_status = "Excluded"
        i += 1
        continue

    # ---------- BUILDING ----------
    if any(x in line for x in ["Bldg", "Tower", "Food Court", "Parkade", "Unitel", "Acre"]):
        current_building = line
        i += 1
        continue

    # ---------- TOTALS ----------
    if "Totals:" in line:

        block = line
        j = i + 1

        while j < len(lines) and not lines[j].startswith("Database:"):
            block += " " + lines[j]
            j += 1

        nums = re.findall(r'[-\d,]+\.\d+', block)
        nums = [clean_num(n) for n in nums]

        perc = re.search(r'\d+\.\d+%', block)

        totals.append({
            "Building Name": current_building,
            "Building ID": current_building.split()[0] if current_building != "Unknown" else "",
            "Type": "Grand Total" if "Grand" in block else "Building Total",
            "Percentage": perc.group() if perc else "",
            "Square Feet": nums[0] if len(nums) > 0 else None,
            "Monthly Base Rent": nums[1] if len(nums) > 1 else None,
            "Monthly Cost Recovery": nums[2] if len(nums) > 2 else None,
            "Monthly Other Income": nums[3] if len(nums) > 3 else None
        })

        i = j
        continue

    # ---------- UNIT ROW ----------
    if is_unit_row(line):

        full_line = line

        j = i + 1

        # merge continuation lines
        while j < len(lines):
            next_line = lines[j]

            if is_unit_row(next_line):
                break
            if "Totals:" in next_line:
                break
            if "Units" in next_line:
                break

            # skip noise but don't break row
            if is_noise(next_line):
                j += 1
                continue

            full_line += " " + next_line
            j += 1

        i = j - 1

        tokens = full_line.split()

        building_id = tokens[0]
        suite_id = tokens[1] if len(tokens) > 1 else ""

        # ---------- VACANT ----------
        if "Vacant" in full_line:
            occupant = "N/A"
        else:
            dates = re.findall(r'\d{1,2}/\d{1,2}/\d{4}', full_line)
            nums = re.findall(r'[-\d,]+\.\d+', full_line)

            prefix = full_line
            prefix = prefix.replace(building_id, "", 1)
            prefix = prefix.replace(suite_id, "", 1)

            for d in dates:
                prefix = prefix.replace(d, "")

            for n in nums:
                prefix = prefix.replace(n, "")

            occupant = prefix.strip()

        # ---------- NUMERIC ----------
        nums = re.findall(r'[-\d,]+\.\d+', full_line)
        nums = [clean_num(n) for n in nums]

        # ---------- DATES ----------
        dates = re.findall(r'\d{1,2}/\d{1,2}/\d{4}', full_line)

        records.append({
            "Building Name": current_building,
            "Building ID": building_id,
            "Suite ID": suite_id,
            "Occupant Name": occupant if occupant else "N/A",
            "Rent Start": dates[0] if len(dates) > 0 else "",
            "Expiration": dates[1] if len(dates) > 1 else "",
            "GLA Sqft": nums[0] if len(nums) > 0 else None,
            "Monthly Base Rent": nums[1] if len(nums) > 1 else None,
            "Annual Rate PSF": nums[2] if len(nums) > 2 else None,
            "Status": current_status
        })

    i += 1


# ---------- DATAFRAMES ----------

df_units = pd.DataFrame(records)
df_totals = pd.DataFrame(totals)

print(f"\nUnits Extracted: {len(df_units)}")
print(f"Totals Extracted: {len(df_totals)}")


# ---------- OUTPUT ----------

with pd.ExcelWriter(output_excel, engine="openpyxl") as writer:
    df_units.to_excel(writer, sheet_name="Unit Level", index=False)
    df_totals.to_excel(writer, sheet_name="Property Totals", index=False)

print(f"\nSaved to: {output_excel}")