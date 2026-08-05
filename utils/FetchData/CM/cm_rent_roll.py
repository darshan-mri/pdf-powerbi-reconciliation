# import re
# import pandas as pd
# from PyPDF2 import PdfReader
# from utils.config_util import Config
#
# # ---------- CONFIG ----------
# cfg = Config()
# pdf_path = cfg.get("CM.ROLL", "PDF")
# output_excel = cfg.get("CM.ROLL", "ExtractedBuilding")
#
# # ---------- READ PDF ----------
# reader = PdfReader(pdf_path)
# lines = []
#
# for page in reader.pages:
#     text = page.extract_text()
#     if text:
#         lines.extend(text.split("\n"))
#
# lines = [l.strip() for l in lines if l.strip()]
#
#
# # ---------- HELPERS ----------
#
# def is_building_header(line):
#     # Example: 312B01 201 Portage Office Tower
#     return bool(re.match(r'^[A-Z0-9]{5,10}\s+[A-Za-z]', line))
#
#
# def is_totals_start(line):
#     return "Totals:" in line
#
#
# def clean_num(x):
#     return float(x.replace(",", ""))
#
#
# def extract_units(text):
#     text = re.sub(r'(\d)Units(\d)', r'\1Units \2', text)
#     units = re.findall(r'(\d+)\s*Units', text)
#     occ = units[0] if len(units) > 0 else "0"
#     vac = units[1] if len(units) > 1 else "0"
#     return occ, vac
#
#
# def parse_totals_block(block):
#
#     block = re.sub(r'(\d)Units(\d)', r'\1Units \2', block)
#
#     nums = re.findall(r'[-\d,]+\.\d+', block)
#     nums = [clean_num(n) for n in nums]
#
#     perc = re.findall(r'\d+\.\d+%', block)
#
#     occ_units, vac_units = extract_units(block)
#
#     return {
#         "Occupied Sqft": nums[0] if len(nums) > 0 else None,
#         "Occupied Monthly Base Rent": nums[1] if len(nums) > 1 else None,
#         "Occupied Monthly Cost Recovery": nums[2] if len(nums) > 2 else None,
#         "Occupied Monthly Other Income": nums[3] if len(nums) > 3 else None,
#
#         "Vacant Sqft": nums[4] if len(nums) > 4 else None,
#         "Vacant Monthly Base Rent": nums[5] if len(nums) > 5 else None,
#         "Vacant Monthly Cost Recovery": nums[6] if len(nums) > 6 else None,
#         "Vacant Monthly Other Income": nums[7] if len(nums) > 7 else None,
#
#         "Occupied %": perc[0] if len(perc) > 0 else "",
#         "Vacant %": perc[1] if len(perc) > 1 else "",
#
#         "Occupied Units": occ_units,
#         "Vacant Units": vac_units,
#     }
#
#
# # ---------- MAIN PARSING ----------
#
# current_building = "Unknown"
# records = []
#
# i = 0
# while i < len(lines):
#
#     line = lines[i]
#
#     # ---------- BUILDING ----------
#     if is_building_header(line):
#         current_building = line.split()[0]  # only ID
#         i += 1
#         continue
#
#     # ---------- TOTALS ----------
#     if is_totals_start(line):
#
#         block = line
#         j = i + 1
#
#         # collect full totals block
#         while j < len(lines):
#             next_line = lines[j]
#
#             if is_totals_start(next_line):
#                 break
#             if is_building_header(next_line):
#                 break
#
#             block += " " + next_line
#             j += 1
#
#         parsed = parse_totals_block(block)
#         parsed["Building ID"] = current_building
#
#         records.append(parsed)
#
#         i = j
#         continue
#
#     i += 1
#
#
# # ---------- DATAFRAME ----------
# df = pd.DataFrame(records)
#
# cols = [
#     "Building ID",
#     "Occupied Sqft", "Occupied %",
#     "Occupied Units",
#     "Occupied Monthly Base Rent", "Occupied Monthly Cost Recovery", "Occupied Monthly Other Income",
#     "Vacant Sqft", "Vacant %",
#     "Vacant Units",
#     "Vacant Monthly Base Rent", "Vacant Monthly Cost Recovery", "Vacant Monthly Other Income"
# ]
#
# for c in cols:
#     if c not in df.columns:
#         df[c] = None
#
# df = df[cols]
#
# # ---------- SAVE ----------
# df.to_excel(output_excel, index=False)
#
# print(f"Saved {len(df)} rows → {output_excel}")
# print(df.head())


import re
import pandas as pd
from PyPDF2 import PdfReader
from utils.config_util import Config

# ---------- CONFIG ----------
cfg = Config()
pdf_path = cfg.get("CM.ROLL", "PDF")
output_excel = cfg.get("CM.ROLL", "ExtractedBuilding")

# ---------- READ PDF ----------
reader = PdfReader(pdf_path)
lines = []

for page in reader.pages:
    text = page.extract_text()
    if text:
        lines.extend(text.split("\n"))

lines = [l.strip() for l in lines if l.strip()]

print(f"Total lines read: {len(lines)}")


# ---------- NORMALIZE ----------
normalized_lines = []
for l in lines:
    l = l.replace("OccupiedSqft", "Occupied Sqft")
    l = l.replace("VacantSqft", "Vacant Sqft")
    l = l.replace("Leased/UnoccupiedSqft", "Leased/Unoccupied Sqft")
    normalized_lines.append(l)

lines = normalized_lines


# ---------- HELPERS ----------

def is_building_header(line):
    return bool(re.match(r'^[A-Z0-9]{5,10}\s+', line))


def is_totals_start(line):
    return bool(re.search(r'Occupied\s*Sqft', line, re.IGNORECASE))


def extract_units(text):
    text = re.sub(r'(\d)Units(\d)', r'\1Units \2', text)
    m = re.search(r'(\d+)\s*Units', text)
    return int(m.group(1)) if m else 0


# ---------- MAIN ----------
current_building = "Unknown"
records = []

i = 0
while i < len(lines):

    line = lines[i]

    # ---------- BUILDING ----------
    if is_building_header(line):
        current_building = line.split()[0]
        i += 1
        continue

    # ---------- TOTALS ----------
    if is_totals_start(line):

        print(f"\n[DEBUG] Totals detected at line {i}: {line}")

        block = line
        j = i + 1

        while j < len(lines):
            next_line = lines[j]

            if is_building_header(next_line):
                break

            if is_totals_start(next_line) and j != i:
                break

            block += " " + next_line
            j += 1

        # ---------- PARSE ----------
        occ_section = re.search(
            r'Occupied\s*Sqft:(.*?)(Leased/Unoccupied\s*Sqft|Vacant\s*Sqft)',
            block,
            re.IGNORECASE
        )
        leased_section = re.search(
            r'Leased/Unoccupied\s*Sqft:(.*?)(Vacant\s*Sqft|Total\s*Sqft|$)',
            block,
            re.IGNORECASE
        )
        vac_section = re.search(
            r'Vacant\s*Sqft:(.*?)(Total\s*Sqft|$)',
            block,
            re.IGNORECASE
        )

        occ_units = extract_units(occ_section.group(1)) if occ_section else 0
        vac_units = extract_units(leased_section.group(1)) if leased_section else 0

        if vac_units == 0 and vac_section:
            vac_units = extract_units(vac_section.group(1))

        total_units = occ_units + vac_units

        print(f"[DEBUG] Building: {current_building}, Occ: {occ_units}, Vac: {vac_units}")

        records.append({
            "Building ID": current_building,
            "Occupied Units": occ_units,
            "Vacant Units": vac_units,
            "Total Units": total_units
        })

        i = j
        continue

    i += 1


# ---------- DATAFRAME ----------
df = pd.DataFrame(records)

if df.empty:
    print("\n❌ No totals extracted — check debug logs above")
else:
    df = df[
        ["Building ID", "Occupied Units", "Vacant Units", "Total Units"]
    ]

    df.to_excel(output_excel, index=False)

    print(f"\n✅ Saved {len(df)} rows → {output_excel}")
    print(df.head())