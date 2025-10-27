#prints all but not exact data
# import pdfplumber
# import pandas as pd
# import re
# from utils.config_util import Config
# from itertools import groupby
#
# # ---------- CONFIG ----------
# cfg = Config()
# pdf_path = cfg.get("CM.ROLL", "PDF")
# output_excel = cfg.get("CM.ROLL", "ExtractedSuites")
#
# columns = [
#     "Building ID", "Suite ID", "Occupant Name", "Rent Start", "Expiration",
#     "Sqft", "Monthly Base Rent", "Rate PSF", "Monthly Cost Recovery",
#     "Monthly Other Income", "Status"
# ]
#
# records = []
# current_section = None
#
# # ---------- HELPERS ----------
#
# def group_words_by_line(words, tol=3):
#     """Group words into lines based on y-coordinate."""
#     words_sorted = sorted(words, key=lambda w: w['top'])
#     lines = []
#     for k, g in groupby(words_sorted, key=lambda w: round(w['top']/tol)):
#         lines.append(list(g))
#     return lines
#
# def detect_header_line(lines):
#     """Detect the header line containing column titles."""
#     for line in lines:
#         for w in line:
#             if 'BldgId' in w['text'] or 'SuitId' in w['text']:
#                 return line
#     return None
#
# def get_column_positions(header_line):
#     """Return column names and their x0/x1 positions."""
#     mapping = {
#         'BldgId': 'Building ID',
#         'SuitId': 'Suite ID',
#         'OccupantName': 'Occupant Name',
#         'RentStart': 'Rent Start',
#         'Expiration': 'Expiration',
#         'Sqft': 'Sqft',
#         'BaseRent': 'Monthly Base Rent',
#         'RatePSF': 'Rate PSF',
#         'CostRecovery': 'Monthly Cost Recovery',
#         'OtherIncome': 'Monthly Other Income'
#     }
#     positions = []
#     for w in header_line:
#         key = w['text'].replace(" ", "")
#         if key in mapping:
#             positions.append((mapping[key], w['x0'], w['x1']))
#     positions.sort(key=lambda x: x[1])
#     return positions
#
# def assign_word_to_column(word, col_positions):
#     for i, (_, x0, x1) in enumerate(col_positions):
#         if x0 - 5 <= word['x0'] <= x1 + 5:
#             return i
#     return None
#
# def fix_building_suite(row):
#     """Fix split or merged BuildingID + SuiteID"""
#     bldg, suite = row[0].strip(), row[1].strip()
#     if not suite or suite == "0":
#         combined = bldg
#         m = re.match(r"([A-Z]{3}\d{5,})(\d*)", combined)
#         if m:
#             full = m.group(1)
#             bldg = full[:8]  # first 8 chars as building
#             suite = full[8:] or m.group(2) or "0"
#     return bldg, suite
#
# def parse_number(value):
#     """Convert string to float, remove commas and parentheses"""
#     value = value.replace(",", "").replace("(", "-").replace(")", "").strip()
#     try:
#         return float(value) if value else 0
#     except:
#         return 0
#
# def is_valid_suite_row(row):
#     """Return True if the row looks like a suite row."""
#     bldg, suite = row[0].strip(), row[1].strip()
#     junk_keywords = ["OccupiedSuites","VacantSuites","NewLeases","GLA","Monthly",
#                      "Annual","Leased/UnoccupiedSqft:","AreaIncludedNotCountedSqft:"]
#     row_text = "".join(row).replace(" ", "")
#     if any(k in row_text for k in junk_keywords):
#         return False
#     if bldg == "" and suite == "":
#         return False
#     if re.match(r"[A-Z]*\d+", bldg) or re.match(r"\d+", suite):
#         return True
#     return False
#
# # ---------- EXTRACTION ----------
#
# with pdfplumber.open(pdf_path) as pdf:
#     for page in pdf.pages:
#         words = page.extract_words()
#         lines = group_words_by_line(words)
#         page_text = page.extract_text() or ""
#
#         # Detect section
#         if "Occupied Suites" in page_text:
#             current_section = "Occupied"
#         elif "Vacant Suites" in page_text:
#             current_section = "Vacant"
#         elif "New Leases" in page_text:
#             current_section = "New Lease"
#
#         # Detect header line
#         header_line = detect_header_line(lines)
#         if not header_line:
#             continue
#         col_positions = get_column_positions(header_line)
#         header_y = min(w['top'] for w in header_line)
#
#         for line in lines:
#             if min(w['top'] for w in line) <= header_y:
#                 continue  # skip header itself
#
#             # Map words to columns
#             row = [""] * len(col_positions)
#             for w in line:
#                 idx = assign_word_to_column(w, col_positions)
#                 if idx is not None:
#                     row[idx] += (" " + w["text"]).strip()
#
#             if not is_valid_suite_row(row):
#                 continue  # skip junk rows
#
#             # Fix Building/Suite ID
#             if row[0] and (not row[1] or row[1] == "0"):
#                 bldg, suite = fix_building_suite(row)
#                 row[0], row[1] = bldg, suite
#
#             # Parse numeric columns
#             for i, (col_name, _, _) in enumerate(col_positions):
#                 if col_name in ["Sqft", "Monthly Base Rent", "Rate PSF", "Monthly Cost Recovery", "Monthly Other Income"]:
#                     row[i] = parse_number(row[i])
#
#             final_row = {col: "" for col in columns}
#             for i, (col_name, _, _) in enumerate(col_positions):
#                 final_row[col_name] = row[i]
#
#             # Assign section status
#             final_row["Status"] = current_section or "Vacant"  # default to Vacant
#
#             records.append(final_row)
#
# # ---------- SAVE TO EXCEL ----------
# df = pd.DataFrame(records, columns=columns)
# df.to_excel(output_excel, index=False)
# print(f"✅ Extracted {len(df)} rows → {output_excel}")

#Almost there version
# import re
# import pdfplumber
# import pandas as pd
# from utils.config_util import Config
# from itertools import groupby
#
# # ---------- CONFIG ----------
# cfg = Config()
# pdf_path = cfg.get("CM.ROLL", "PDF")
# output_excel = cfg.get("CM.ROLL", "ExtractedSuites")
#
# # ---------- HELPERS ----------
#
# def group_words_by_line(words, tol=3):
#     """Group nearby words into lines."""
#     words_sorted = sorted(words, key=lambda w: w["top"])
#     lines = []
#     for _, g in groupby(words_sorted, key=lambda w: round(w["top"] / tol)):
#         lines.append(list(g))
#     return lines
#
# def extract_building_name(lines):
#     """Find building name from 'BldgStatus:' line."""
#     for line in lines:
#         text = " ".join(w["text"] for w in line)
#         m = re.search(r"^([A-Za-z0-9&'().,\- ]+)\s+BldgStatus:", text)
#         if m:
#             return m.group(1).strip()
#     return None
#
# def detect_section(line_text):
#     """Detect section name based on keywords."""
#     if re.search(r"Occupied\s*Suites", line_text, re.I):
#         return "Occupied"
#     if re.search(r"Vacant\s*Suites", line_text, re.I):
#         return "Vacant"
#     if re.search(r"New\s*Leases", line_text, re.I):
#         return "New Lease"
#     return None
#
# def parse_suite_line(text):
#     """
#     Parse a suite data line.
#     Example:
#     5150 8505 CarrollIndependentFuel 9/1/1998 8/31/2028 1,770 4,000.00 27.12
#     """
#     m = re.match(
#         r"^(?P<BuildingID>[A-Z0-9]+)\s+(?P<SuiteID>[A-Za-z0-9]+)\s+(?P<Occupant>.+?)\s+(?P<RentStart>\d{1,2}/\d{1,2}/\d{2,4})?\s*(?P<Expiration>\d{1,2}/\d{1,2}/\d{2,4})?\s*(?P<Sqft>[\d,]+)?\s*(?P<BaseRent>[\d,]+\.\d{2})?\s*(?P<RatePSF>[\d,]+\.\d{2})?",
#         text,
#     )
#     return m.groupdict() if m else None
#
# # ---------- EXTRACTION ----------
#
# records = []
# current_section = None
# current_building = None
#
# with pdfplumber.open(pdf_path) as pdf:
#     for page in pdf.pages:
#         lines = group_words_by_line(page.extract_words())
#         page_text = page.extract_text() or ""
#
#         # Update building name if found
#         bldg_name = extract_building_name(lines)
#         if bldg_name:
#             current_building = bldg_name
#
#         # Iterate through lines
#         for line in lines:
#             text = " ".join(w["text"] for w in line).strip()
#             if not text:
#                 continue
#
#             # Detect section changes (Occupied/Vacant/New Lease)
#             section = detect_section(text)
#             if section:
#                 current_section = section
#                 continue
#
#             # Skip summary / totals
#             if re.match(r"Totals:|Leased/Unoccupied|VacantSqft|AreaIncluded|GLA", text):
#                 continue
#
#             # Parse suite line
#             parsed = parse_suite_line(text)
#             if parsed and parsed.get("BuildingID"):
#                 record = {
#                     "Building ID": parsed.get("BuildingID", ""),
#                     "Suite ID": parsed.get("SuiteID", ""),
#                     "Occupant Name": parsed.get("Occupant", ""),
#                     "Rent Start": parsed.get("RentStart", ""),
#                     "Expiration": parsed.get("Expiration", ""),
#                     "Sqft": parsed.get("Sqft", ""),
#                     "Monthly Base Rent": parsed.get("BaseRent", ""),
#                     "Rate PSF": parsed.get("RatePSF", ""),
#                     "Monthly Cost Recovery": "",
#                     "Monthly Other Income": "",
#                     "Status": current_section or "<unknown>",
#                     "Building Name": current_building or "<unknown>",
#                 }
#                 records.append(record)
#
# # ---------- OUTPUT ----------
# df = pd.DataFrame(records)
# print(f"✅ Extracted {len(df)} rows across all sections.")
# if not df.empty:
#     print(df.head(15))
# df.to_excel(output_excel, index=False)
# print(f"✅ Saved extracted suites → {output_excel}")

#Second best working version
import re
import pdfplumber
import pandas as pd
from utils.config_util import Config
from itertools import groupby

# ---------- CONFIG ----------
cfg = Config()
pdf_path = cfg.get("CM.ROLL", "PDF")
output_excel = cfg.get("CM.ROLL", "ExtractedSuites")

# ---------- MASTER BUILDING IDS ----------
MASTER_BUILDINGS = [
    "5110","5150","JAL001","JAM001","JAO001","JAP001","JAQ001",
    "JAS001","JAX001","JAY001","JBA001","JBC001"
]

NUMERIC_RE = re.compile(r"^-?[\d,]+(?:\.\d+)?$")

# ---------- HELPERS ----------

def group_words_by_line(words, tol=3):
    words_sorted = sorted(words, key=lambda w: w["top"])
    lines = []
    for _, g in groupby(words_sorted, key=lambda w: round(w["top"] / tol)):
        lines.append(list(g))
    return lines

def extract_building_name(lines):
    for line in lines:
        text = " ".join(w["text"] for w in line)
        m = re.search(r"^([A-Za-z0-9&'().,\- ]+)\s+BldgStatus:", text)
        if m:
            return m.group(1).strip()
    return None

def detect_section(text):
    if re.search(r"Occupied\s*Suites", text, re.I):
        return "Occupied"
    if re.search(r"Vacant\s*Suites", text, re.I):
        return "Vacant"
    if re.search(r"New\s*Leases", text, re.I):
        return "New Lease"
    return None

def split_building_suite(token):
    """Use master building ID list to split first token into Building ID and Suite ID"""
    for bldg in MASTER_BUILDINGS:
        if token.startswith(bldg):
            suite = token[len(bldg):].strip()
            return bldg, suite
    return token, ""  # fallback

# ---------- EXTRACTION ----------

records = []
current_section = None
current_building = None
current_record = None

with pdfplumber.open(pdf_path) as pdf:
    for page in pdf.pages:
        lines = group_words_by_line(page.extract_words())
        for line in lines:
            tokens = [w["text"].strip() for w in line if w["text"].strip()]
            if not tokens:
                continue

            # Skip headers / totals / irrelevant lines
            if any(re.search(k, tokens[0], re.I) for k in ["GLA","RentRoll","BldgStatus","Database","Time","SuitId","Total"]):
                continue

            # Update building name if found
            bldg_name = extract_building_name([line])
            if bldg_name:
                current_building = bldg_name

            # Detect section
            section = detect_section(" ".join(tokens))
            if section:
                current_section = section
                continue

            # If line starts with known building ID or contains suite ID, parse new suite
            bldg_id_candidate, suite_candidate = split_building_suite(tokens[0])
            if bldg_id_candidate in MASTER_BUILDINGS:
                # Fix shifted columns
                if not suite_candidate:
                    if len(tokens) > 1:
                        suite_candidate = tokens[1]
                        occupant_tokens = tokens[2:]
                    else:
                        suite_candidate = ""
                        occupant_tokens = tokens[1:]
                else:
                    occupant_tokens = tokens[1:]

                # Extract dates if any
                date_indices = [i for i, t in enumerate(occupant_tokens) if re.match(r"\d{1,2}/\d{1,2}/\d{2,4}", t)]
                if date_indices:
                    first_date_idx = date_indices[0]
                    occupant_name = " ".join(occupant_tokens[:first_date_idx])
                    rent_start = occupant_tokens[first_date_idx]
                    expiration = occupant_tokens[first_date_idx+1] if len(occupant_tokens) > first_date_idx+1 else ""
                    numeric_tokens = occupant_tokens[first_date_idx+2:]
                else:
                    occupant_name = " ".join(occupant_tokens)
                    rent_start = ""
                    expiration = ""
                    numeric_tokens = []

                # Initialize numeric fields
                numeric_values = [t.replace(",","") for t in numeric_tokens if NUMERIC_RE.match(t)]
                record = {
                    "Building ID": bldg_id_candidate,
                    "Suite ID": suite_candidate,
                    "Occupant Name": occupant_name,
                    "Rent Start": rent_start,
                    "Expiration": expiration,
                    "GLA Sqft": numeric_values[0] if len(numeric_values) > 0 else "",
                    "Monthly Base Rent": numeric_values[1] if len(numeric_values) > 1 else "",
                    "Annual Rate PSF": numeric_values[2] if len(numeric_values) > 2 else "",
                    "Monthly Cost Recovery": numeric_values[3] if len(numeric_values) > 3 else "",
                    "Expense Stop": numeric_values[4] if len(numeric_values) > 4 else "",
                    "Monthly Other Income": numeric_values[5] if len(numeric_values) > 5 else "",
                    "Status": current_section or "<unknown>",
                    "Building Name": current_building or "<unknown>",
                }

                # --- Vacant row fix ---
                if record["Occupant Name"].upper().startswith("VACANT"):
                    parts = record["Occupant Name"].split(maxsplit=1)
                    record["Occupant Name"] = parts[0]
                    if len(parts) > 1:
                        record["GLA Sqft"] = parts[1].replace(",", "")

                # Append record
                records.append(record)
                current_record = record
                continue

            # Handle continuation numeric rows (like RNT rows)
            if current_record:
                numeric_values = [t.replace(",","") for t in tokens if NUMERIC_RE.match(t)]
                if numeric_values:
                    # Assign remaining numeric fields if empty
                    for col, val in zip(["Monthly Cost Recovery","Expense Stop","Monthly Other Income"], numeric_values):
                        if current_record[col] == "":
                            current_record[col] = val

# ---------- OUTPUT ----------

df = pd.DataFrame(records)
print(f"✅ Extracted {len(df)} rows across all sections.")
if not df.empty:
    print(df.head(30))
df.to_excel(output_excel, index=False)
print(f"✅ Saved extracted suites → {output_excel}")




