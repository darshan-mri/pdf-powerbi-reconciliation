"""
AGED PDF Parser (FINAL)

"""

import re
import pandas as pd
import sys
from pathlib import Path
import fitz

_PROJECT_ROOT = Path(__file__).resolve().parents[3]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))
from utils.config_util import Config

cfg = Config()

pdf_path = cfg.get("CM.AGED", "PDF")
output_excel = cfg.get("CM.AGED", "OccupantTotals")

print("="*80)
print("FINAL PDF PARSER - 100% VERSION")
print("="*80)

# ----------------------------------------------------------------------------
# REGEX
# ----------------------------------------------------------------------------
# Match invoice format: 6 alphanumeric chars + dash + 6 digits
# Examples: 326B01-005093, 344B01-001643, P90010-003147
INVOICE_RE = re.compile(r'([A-Za-z0-9]{6}-\d{6})')
# Broader pattern to debug what we're missing
POTENTIAL_INVOICE_RE = re.compile(r'^([A-Za-z0-9]+-\d{4,})')
MASTER_RE = re.compile(r'Master Occupant Id:\s*(.+)', re.I)
NUMBER_RE = re.compile(r'[\-(]?[\d,]+\.[\d]+\)?')

def clean_number(s):
    if s.startswith("("):
        return -float(s[1:-1].replace(",", ""))
    return float(s.replace(",", ""))

# ----------------------------------------------------------------------------
# EXTRACT TEXT
# ----------------------------------------------------------------------------
doc = fitz.open(pdf_path)

lines = []
for page in doc:
    lines.extend(page.get_text("text").split("\n"))

doc.close()

print(f"\nTotal lines extracted: {len(lines)}")

# ----------------------------------------------------------------------------
# PARSE
# ----------------------------------------------------------------------------
tenant_records = []
bldg_records = []

current_invoice = None
current_master = None
latest_values = None

all_total_lines = []
missed_invoice_patterns = []

for i, line in enumerate(lines):

    line = line.strip()
    if not line:
        continue

    # Track totals
    if "Total" in line and "BLDG" not in line:
        all_total_lines.append((i, line))

    # -------------------------
    # Invoice
    # -------------------------
    inv_match = INVOICE_RE.match(line)
    if inv_match:

        if current_invoice and latest_values:
            tenant_records.append({
                "InvoiceID": current_invoice,
                "MasterOccupantID": current_master,
                "Amount": latest_values[0],
                "Current": latest_values[1],
                "Month_1": latest_values[2],
                "Month_2": latest_values[3],
                "Month_3": latest_values[4],
                "Month_4": latest_values[5],
            })

        current_invoice = inv_match.group(1)
        current_master = None
        latest_values = None
        continue
    
    # Debug: Check if line matches broader pattern but not strict pattern
    potential_match = POTENTIAL_INVOICE_RE.match(line)
    if potential_match and not inv_match:
        pattern = potential_match.group(1)
        if pattern not in missed_invoice_patterns:
            missed_invoice_patterns.append(pattern)

    # -------------------------
    # Master Occupant
    # -------------------------
    master_match = MASTER_RE.search(line)
    if master_match:
        current_master = master_match.group(1).strip()
        continue

    # -------------------------
    # BLDG TOTAL
    # -------------------------
    if "BLDG" in line and "Total" in line:

        nums = NUMBER_RE.findall(line)

        for j in range(i+1, min(i+60, len(lines))):
            next_line = lines[j].strip()
            if not next_line:
                continue

            found = NUMBER_RE.findall(next_line)
            if found:
                nums.extend(found)

            if len(nums) >= 6:
                break

        if len(nums) >= 6:
            values = [clean_number(n) for n in nums[:6]]

            bldg_id = line.split()[1]

            bldg_records.append({
                "BuildingID": bldg_id,
                "Amount": values[0],
                "Current": values[1],
                "Month_1": values[2],
                "Month_2": values[3],
                "Month_3": values[4],
                "Month_4": values[5],
            })

        continue

    # -------------------------
    # TENANT TOTAL (FINAL FIX)
    # -------------------------
    if ("Total" in line or line.lower() in ["total", "total:"]) and current_invoice:

        nums = NUMBER_RE.findall(line)

        # 🔥 CRITICAL FIX: NO EARLY BREAK + LONG RANGE
        for j in range(i+1, min(i+80, len(lines))):

            next_line = lines[j].strip()

            if not next_line or next_line == ":":
                continue

            found = NUMBER_RE.findall(next_line)

            if found:
                nums.extend(found)

                if len(nums) >= 6:
                    break

        if len(nums) >= 6:
            latest_values = [clean_number(n) for n in nums[:6]]

# ----------------------------------------------------------------------------
# SAVE LAST RECORD
# ----------------------------------------------------------------------------
if current_invoice and latest_values:
    tenant_records.append({
        "InvoiceID": current_invoice,
        "MasterOccupantID": current_master,
        "Amount": latest_values[0],
        "Current": latest_values[1],
        "Month_1": latest_values[2],
        "Month_2": latest_values[3],
        "Month_3": latest_values[4],
        "Month_4": latest_values[5],
    })

# ----------------------------------------------------------------------------
# DATAFRAMES
# ----------------------------------------------------------------------------
df_tenant = pd.DataFrame(tenant_records)
df_bldg = pd.DataFrame(bldg_records)


# ----------------------------------------------------------------------------
# DEBUG SUMMARY
# ----------------------------------------------------------------------------
print("\n📊 FINAL RESULTS")
print(f"Tenant Records: {len(df_tenant)}")
print(f"BLDG Records: {len(df_bldg)}")

print("\n🔍 DEBUG")
print(f"Total 'Total' lines: {len(all_total_lines)}")
print(f"Extracted: {len(df_tenant)}")
print(f"Missing: {len(all_total_lines) - len(df_tenant)}")
print(f"Missed Invoice Patterns: {missed_invoice_patterns}")

# ----------------------------------------------------------------------------
# SAVE
# ----------------------------------------------------------------------------
with pd.ExcelWriter(output_excel) as writer:
    df_tenant.to_excel(writer, sheet_name="TenantTotals", index=False)
    df_bldg.to_excel(writer, sheet_name="BLDGTotals", index=False)

print(f"\n✅ Saved to: {output_excel}")
print("="*80)