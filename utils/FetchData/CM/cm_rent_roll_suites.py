"""
PDF Rent Roll Suite Extractor
Extracts suite data from Commercial Property Rent Roll PDFs
"""

import re
import pdfplumber
import pandas as pd
from utils.config_util import Config

# ---------- CONFIG ----------
cfg = Config()
pdf_path = cfg.get("CM.ROLL", "PDF")
output_excel = cfg.get("CM.ROLL", "ExtractedSuites")

print(f"Reading PDF: {pdf_path}")
print(f"Output will be saved to: {output_excel}\n")

# ---------- HELPERS ----------

def clean_numeric(value):
    """Convert string to float, handling commas and parentheses"""
    if not value or value == "":
        return None
    if isinstance(value, (int, float)):
        return float(value)
    cleaned = str(value).replace(",", "").replace("(", "-").replace(")", "").strip()
    if cleaned == "" or cleaned == "-":
        return None
    try:
        return float(cleaned)
    except:
        return None

def is_building_suite_id(text):
    """
    Check if text looks like a building/suite ID.
    Supports:
    - Uppercase: B00100DOCK, M05500SITE
    - Lowercase: m05511SITE, m05515SITE
    - Multi-letter format: TCRCNY12H, TCRCNY26D, TCRCNY9G (6 letters + alphanumeric)

    Patterns:
    1. Letter + 5 digits + optional suite: B00100DOCK, m05511SITE
    2. 5-6 letters followed by alphanumeric: TCRCNY12H, TCRCNY26D
    """
    # Pattern 1: Letter + 5 digits (e.g., B00100, m05511)
    if re.match(r'^[a-zA-Z]\d{5}', text):
        return True

    # Pattern 2: 5-6 letters followed by alphanumeric (e.g., TCRCNY12H, TCRCNY26D, TCRCNY9G)
    if re.match(r'^[a-zA-Z]{5,6}\w+', text):
        return True

    return False

def is_future_rent_line(text):
    """Check if this is a future rent increase line (starts with BAS, CAM, CON, etc.)"""
    return bool(re.match(r'^(BAS|CAM|CON|GST|MST|HM|PER|LIC|ABR|ADR|INT|BSR|PAR|MGT|BTR)\s+\d{1,2}/\d{1,2}/\d{4}', text))

def parse_suite_row(row_text):
    """
    Parse a suite data row from the rent roll PDF.
    Expected format: BldgIdSuiteId OccupantName RentStart Expiration GLASqft MonthlyBaseRent AnnualRatePSF...
    Example: B001009DOCK United Parcel Service, Inc. 11/20/2025 1/17/2026 0
    """
    # Remove future rent data (everything after BAS, CAM, CON, etc.)
    future_rent_pattern = r'(BAS|CAM|CON|GST|MST|HM|PER|LIC|ABR|ADR|INT|BSR|PAR|MGT|BTR)\s+\d{1,2}/\d{1,2}/\d{4}'
    match = re.search(future_rent_pattern, row_text)
    if match:
        row_text = row_text[:match.start()].strip()

    # Split into tokens
    tokens = row_text.split()
    if len(tokens) < 2:
        return None

    # Extract Building ID and Suite ID (combined like "B001002M" or "TCRCNY9BHA")
    building_suite = tokens[0]
    if not is_building_suite_id(building_suite):
        return None

    # Split building and suite ID
    # For format like B00100DOCK: Building ID = B00100 (6 chars), Suite ID = DOCK
    # For format like TCRCNY12H: Building ID = TCRCNY (6 chars), Suite ID = 12H
    # For format like TCRCNY26D: Building ID = TCRCNY (6 chars), Suite ID = 26D

    # Determine building ID length based on format
    if re.match(r'^[a-zA-Z]\d{5}', building_suite):
        # Pattern: Letter + 5 digits (e.g., B00100, m05511)
        building_id = building_suite[:6].upper()
        suite_id = building_suite[6:] if len(building_suite) > 6 else ""
    elif re.match(r'^[a-zA-Z]{6}', building_suite):
        # Pattern: Exactly 6 letters (e.g., TCRCNY)
        # Building ID is first 6 letters, rest is suite ID
        building_id = building_suite[:6].upper()
        suite_id = building_suite[6:] if len(building_suite) > 6 else ""
    else:
        # Fallback: assume 6 character building ID
        building_id = building_suite[:6].upper()
        suite_id = building_suite[6:] if len(building_suite) > 6 else ""

    # Find ALL date-like patterns in tokens
    date_pattern = r'^\d{1,2}/\d{1,2}/\d{4}$'
    date_indices = [i for i in range(len(tokens)) if re.match(date_pattern, tokens[i])]

    # Determine if this is a vacant row (starts with "Vacant" or has "Vacant" as second token)
    is_vacant = len(tokens) > 1 and (tokens[1].lower() == "vacant" or (len(tokens) > 2 and tokens[1].lower() == "vacant" and tokens[2].lower() in ["unknown", ""]))

    # Skip if this looks like a header row (contains "Vacant Unknown" as header text)
    if len(tokens) > 2 and tokens[1] == "Vacant" and tokens[2] == "Unknown":
        return None

    if is_vacant:
        # Vacant format: B00100SUITE Vacant 7,800 (where 7,800 is the sqft)
        # Or: B00100SUITE Vacant Unknown (skip this - it's a header)
        sqft_value = None
        for i in range(2, len(tokens)):
            if tokens[i].lower() not in ["vacant", "unknown", ""]:
                sqft_value = clean_numeric(tokens[i])
                break

        return {
            "Building ID": building_id,
            "Suite ID": suite_id,
            "Occupant Name": "Vacant",
            "Rent Start": "",
            "Expiration": "",
            "GLA Sqft": sqft_value,
            "Monthly Base Rent": None,
            "Annual Rate PSF": None,
            "Monthly Cost Recovery": None,
            "Expense Stop": None,
            "Monthly Other Income": None,
        }

    elif len(date_indices) >= 2:
        # Has both rent start and expiration dates
        first_date_idx = date_indices[0]
        second_date_idx = date_indices[1]

        # Occupant name is between position 1 and first date
        occupant_name = " ".join(tokens[1:first_date_idx])

        rent_start = tokens[first_date_idx]
        expiration = tokens[second_date_idx]

        # Numeric fields come after the second date
        numeric_start = second_date_idx + 1
        numeric_tokens = tokens[numeric_start:]
        numeric_values = [clean_numeric(t) for t in numeric_tokens if clean_numeric(t) is not None]

        return {
            "Building ID": building_id,
            "Suite ID": suite_id,
            "Occupant Name": occupant_name,
            "Rent Start": rent_start,
            "Expiration": expiration,
            "GLA Sqft": numeric_values[0] if len(numeric_values) > 0 else None,
            "Monthly Base Rent": numeric_values[1] if len(numeric_values) > 1 else None,
            "Annual Rate PSF": numeric_values[2] if len(numeric_values) > 2 else None,
            "Monthly Cost Recovery": numeric_values[3] if len(numeric_values) > 3 else None,
            "Expense Stop": numeric_values[4] if len(numeric_values) > 4 else None,
            "Monthly Other Income": numeric_values[5] if len(numeric_values) > 5 else None,
        }

    elif len(date_indices) == 1:
        # Only one date
        date_idx = date_indices[0]
        occupant_name = " ".join(tokens[1:date_idx])
        rent_start = tokens[date_idx]

        # Numeric fields after the date
        numeric_start = date_idx + 1
        numeric_tokens = tokens[numeric_start:]
        numeric_values = [clean_numeric(t) for t in numeric_tokens if clean_numeric(t) is not None]

        return {
            "Building ID": building_id,
            "Suite ID": suite_id,
            "Occupant Name": occupant_name,
            "Rent Start": rent_start,
            "Expiration": "",
            "GLA Sqft": numeric_values[0] if len(numeric_values) > 0 else None,
            "Monthly Base Rent": numeric_values[1] if len(numeric_values) > 1 else None,
            "Annual Rate PSF": numeric_values[2] if len(numeric_values) > 2 else None,
            "Monthly Cost Recovery": numeric_values[3] if len(numeric_values) > 3 else None,
            "Expense Stop": numeric_values[4] if len(numeric_values) > 4 else None,
            "Monthly Other Income": numeric_values[5] if len(numeric_values) > 5 else None,
        }

    else:
        # No dates found - try to extract what we can
        occupant_name = " ".join(tokens[1:])
        numeric_values = [clean_numeric(t) for t in tokens[1:] if clean_numeric(t) is not None]

        return {
            "Building ID": building_id,
            "Suite ID": suite_id,
            "Occupant Name": occupant_name,
            "Rent Start": "",
            "Expiration": "",
            "GLA Sqft": numeric_values[0] if len(numeric_values) > 0 else None,
            "Monthly Base Rent": numeric_values[1] if len(numeric_values) > 1 else None,
            "Annual Rate PSF": numeric_values[2] if len(numeric_values) > 2 else None,
            "Monthly Cost Recovery": numeric_values[3] if len(numeric_values) > 3 else None,
            "Expense Stop": numeric_values[4] if len(numeric_values) > 4 else None,
            "Monthly Other Income": numeric_values[5] if len(numeric_values) > 5 else None,
        }

# ---------- EXTRACTION ----------

records = []
totals_records = []  # New: Store building totals
current_section = "Unknown"
current_building = "Unknown"
current_building_id = "Unknown"  # Track the actual building ID
in_grand_total = False  # Track if we're in the Grand Total section

try:
    with pdfplumber.open(pdf_path) as pdf:
        print(f"Total pages: {len(pdf.pages)}\n")

        for page_num, page in enumerate(pdf.pages, 1):
            text = page.extract_text()
            if not text:
                continue

            lines = text.split('\n')

            for line in lines:
                line = line.strip()
                if not line:
                    continue

                # Check for section headers (case-insensitive and handle spacing variations)
                if re.search(r'Occupied\s*Suites', line, re.IGNORECASE):
                    current_section = "Occupied"
                    print(f"Page {page_num}: Section = {current_section}")
                    continue
                elif re.search(r'Vacant\s*Suites', line, re.IGNORECASE):
                    current_section = "Vacant"
                    print(f"Page {page_num}: Section = {current_section}")
                    continue
                elif re.search(r'New\s*Leases?', line, re.IGNORECASE):
                    current_section = "New Lease"
                    print(f"Page {page_num}: Section = {current_section}")
                    continue

                # Check for building name
                if "BldgStatus:" in line:
                    match = re.search(r"^(.+?)\s+BldgStatus:", line)
                    if match:
                        current_building = match.group(1).strip()
                        print(f"Page {page_num}: Building = {current_building}")
                    continue

                # Check if this is a "Grand Total:" line
                if "Grand Total:" in line or "Grand Totals:" in line:
                    # Set flag to indicate we're in Grand Total section
                    in_grand_total = True

                    # Parse the grand total line - use "Grand Total" as building name
                    # Format: "Grand Total: OccupiedSqft: 100.00% 1Units 49,500 21,202.54 0.00 0.00"

                    # Remove "Grand Total:" or "Grand Totals:" prefix
                    data_part = line.replace("Grand Total:", "").replace("Grand Totals:", "").strip()

                    # Split into tokens
                    tokens = data_part.split()
                    if len(tokens) >= 2:
                        label = tokens[0]  # e.g., "OccupiedSqft:"
                        remaining = tokens[1:]

                        # Extract percentage, units, sqft, and amounts
                        percentage = ""
                        units = ""
                        sqft = None
                        amounts = []

                        for token in remaining:
                            if "%" in token:
                                percentage = token
                            elif "Units" in token or "Unit" in token:
                                units = token
                            else:
                                num = clean_numeric(token)
                                if num is not None:
                                    if sqft is None:
                                        sqft = num
                                    else:
                                        amounts.append(num)

                        totals_record = {
                            "Building": "Grand Total",  # Use "Grand Total" for grand totals
                            "Type": label.replace(":", ""),
                            "Percentage": percentage,
                            "Units": units,
                            "Square Feet": sqft,
                            "Monthly Base Rent": amounts[0] if len(amounts) > 0 else None,
                            "Monthly Cost Recovery": amounts[1] if len(amounts) > 1 else None,
                            "Monthly Other Income": amounts[2] if len(amounts) > 2 else None,
                        }
                        totals_records.append(totals_record)
                        print(f"  [GRAND TOTAL] {label} {percentage} {units} - {sqft:,.0f} sqft" if sqft else f"  [GRAND TOTAL] {label}")
                    continue

                # Check if this is a regular "Totals:" line with data (building-specific)
                if "Totals:" in line and "Sqft:" in line:
                    # Parse the totals summary line
                    # Format: "Totals: OccupiedSqft: 100.00% 1Units 49,500 21,202.54 0.00 0.00"
                    # This is the main line with actual data - need to parse it properly

                    # Remove "Totals: " prefix
                    data_part = line.replace("Totals:", "").strip()

                    # Split into tokens
                    tokens = data_part.split()
                    if len(tokens) >= 2:
                        label = tokens[0]  # e.g., "OccupiedSqft:"
                        remaining = tokens[1:]

                        # Extract percentage, units, sqft, and amounts
                        percentage = ""
                        units = ""
                        sqft = None
                        amounts = []

                        for token in remaining:
                            if "%" in token:
                                percentage = token
                            elif "Units" in token or "Unit" in token:
                                units = token
                            else:
                                num = clean_numeric(token)
                                if num is not None:
                                    if sqft is None:
                                        sqft = num
                                    else:
                                        amounts.append(num)

                        totals_record = {
                            "Building": current_building_id,  # Use building ID instead of building name
                            "Type": label.replace(":", ""),
                            "Percentage": percentage,
                            "Units": units,
                            "Square Feet": sqft,
                            "Monthly Base Rent": amounts[0] if len(amounts) > 0 else None,
                            "Monthly Cost Recovery": amounts[1] if len(amounts) > 1 else None,
                            "Monthly Other Income": amounts[2] if len(amounts) > 2 else None,
                        }
                        totals_records.append(totals_record)
                        print(f"  [TOTAL] {label} {percentage} {units} - {sqft:,.0f} sqft" if sqft else f"  [TOTAL] {label}")
                    continue

                # Check if this is a totals detail line (different format)
                totals_match = re.match(r'^(Occupied\s*Sqft:|Leased/Unoccupied\s*Sqft:|Vacant\s*Sqft:|Area\s*Included\s*Not\s*Counted\s*Sqft:|Total\s*Sqft:)', line, re.IGNORECASE)
                if totals_match:
                    # Parse individual totals line
                    # Format: "OccupiedSqft: 100.00% 1Units 49,500 21,202.54"
                    tokens = line.split()
                    if len(tokens) >= 2:
                        label = tokens[0]  # e.g., "OccupiedSqft:"
                        remaining = tokens[1:]

                        # Extract percentage, units, sqft, and amounts
                        percentage = ""
                        units = ""
                        sqft = None
                        amounts = []

                        for token in remaining:
                            if "%" in token:
                                percentage = token
                            elif "Units" in token or "Unit" in token:
                                units = token
                            else:
                                num = clean_numeric(token)
                                if num is not None:
                                    if sqft is None:
                                        sqft = num
                                    else:
                                        amounts.append(num)

                        totals_record = {
                            "Building": "Grand Total" if in_grand_total else current_building_id,  # Use "Grand Total" if in grand total section
                            "Type": label.replace(":", ""),
                            "Percentage": percentage,
                            "Units": units,
                            "Square Feet": sqft,
                            "Monthly Base Rent": amounts[0] if len(amounts) > 0 else None,
                            "Monthly Cost Recovery": amounts[1] if len(amounts) > 1 else None,
                            "Monthly Other Income": amounts[2] if len(amounts) > 2 else None,
                        }
                        totals_records.append(totals_record)
                        print(f"  [TOTAL] {label} - {sqft} sqft")
                    continue

                # Skip other headers and header-like lines
                if any(keyword in line for keyword in ["Bldg Id", "Suit Id", "Database:", "Rent Roll", "Page:", "BLDGID", "SuitId", "OccupantName", "RentStart", "Expiration", "BaseRent", "RatePSF", "CostRecovery", "OtherIncome", "MonthlyAmount", "Vacant\tUnknown"]):
                    continue

                # Skip lines that look like pure headers
                if line.count('\t') > 5 and any(word in line for word in ["Sqft", "Rent", "Recovery", "Income"]):
                    continue

                # Skip future rent increase lines
                if is_future_rent_line(line):
                    continue

                # Try to parse as suite row
                if is_building_suite_id(line.split()[0] if line.split() else ""):
                    parsed = parse_suite_row(line)
                    if parsed:
                        # Update current building ID from the parsed suite record
                        current_building_id = parsed["Building ID"]

                        parsed["Status"] = current_section
                        parsed["Building Name"] = current_building
                        records.append(parsed)
                        print(f"  [OK] {parsed['Building ID']}{parsed['Suite ID']} - {parsed['Occupant Name'][:40]}")
except Exception as e:
    print(f"Error during extraction: {e}")
    import traceback
    traceback.print_exc()

# ---------- OUTPUT ----------

df = pd.DataFrame(records)
df_totals = pd.DataFrame(totals_records)

print(f"\n{'='*70}")
print(f"Extracted {len(df)} suite records")
print(f"Extracted {len(df_totals)} building totals records")
print(f"{'='*70}\n")

if not df.empty:
    # Reorder columns
    column_order = [
        "Building ID", "Suite ID", "Occupant Name", "Rent Start", "Expiration",
        "GLA Sqft", "Monthly Base Rent", "Annual Rate PSF",
        "Monthly Cost Recovery", "Expense Stop", "Monthly Other Income",
        "Status", "Building Name"
    ]
    df = df[column_order]

    # Replace "Vacant" with "N/A" in Occupant Name column
    df['Occupant Name'] = df['Occupant Name'].replace('Vacant', 'N/A')

    print("First 10 rows:")
    print(df.head(10).to_string())
    print("\n")

    # Summary statistics
    if "Status" in df.columns:
        print("Summary by Status:")
        print(df["Status"].value_counts())
        print()

    if "Building Name" in df.columns:
        print("Summary by Building:")
        print(df["Building Name"].value_counts())
        print()

    # Save to Excel with multiple sheets
    with pd.ExcelWriter(output_excel, engine='openpyxl') as writer:
        df.to_excel(writer, sheet_name='Suites', index=False)

        if not df_totals.empty:
            # Reorder totals columns (only include columns that exist)
            available_cols = df_totals.columns.tolist()
            desired_order = [
                "Building", "Type", "Percentage", "Units",
                "Square Feet", "Monthly Base Rent", "Monthly Cost Recovery", "Monthly Other Income"
            ]
            totals_column_order = [col for col in desired_order if col in available_cols]
            # Add any remaining columns not in the desired order
            for col in available_cols:
                if col not in totals_column_order:
                    totals_column_order.append(col)

            df_totals = df_totals[totals_column_order]
            df_totals.to_excel(writer, sheet_name='Building Totals', index=False)
            print(f"\nBuilding Totals Preview (first 15):")
            print(df_totals.head(15).to_string())

    print(f"\nSaved to: {output_excel}")
    print(f"  - Sheet 1: 'Suites' ({len(df)} rows)")
    print(f"  - Sheet 2: 'Building Totals' ({len(df_totals)} rows)")

    if not df_totals.empty:
        print(f"\nBuilding Totals Summary:")
        print(f"  Total buildings with totals: {df_totals['Building'].nunique()}")
        print(f"  Total records: {len(df_totals)}")
else:
    print("No data extracted! Check PDF structure.")
    # Save empty dataframes
    with pd.ExcelWriter(output_excel, engine='openpyxl') as writer:
        df.to_excel(writer, sheet_name='Suites', index=False)
        df_totals.to_excel(writer, sheet_name='Building Totals', index=False)




