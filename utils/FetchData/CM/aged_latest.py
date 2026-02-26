"""
Parse AGED PDF using PyMuPDF extracted text
Handles both formats:
1. "Tenant Total:" on one line, then 6 values on next lines
2. "Tenant Total: value1 value2 ..." all on one line
"""
import re
import pandas as pd
import sys
import fitz  # PyMuPDF
sys.path.append(r'C:\PDFValidation')
from utils.config_util import Config

cfg = Config()
pdf_path = cfg.get("CM.AGED", "PDF")
txt_path = r'C:\PDFValidation\files\excel\aged_pymupdf_layout.txt'
output_excel = cfg.get("CM.AGED", "OccupantTotals")

print("="*80)
print("EXTRACTING & PARSING AGED PDF")
print("="*80)

# ============================================================================
# STEP 1: EXTRACT TEXT FROM PDF
# ============================================================================
print(f"\n📄 PDF Source: {pdf_path}")

doc = fitz.open(pdf_path)
print(f"   Total Pages: {len(doc)}")

all_text = []
print("\n🔄 Extracting text from PDF...")

for page_num in range(len(doc)):
    page = doc[page_num]
    text = page.get_text("text")
    all_text.append(text)

    if (page_num + 1) % 50 == 0:
        print(f"   Processed {page_num + 1}/{len(doc)} pages...")

doc.close()

# Combine all pages
combined_text = "\n".join(all_text)

# Save to file
with open(txt_path, 'w', encoding='utf-8') as f:
    f.write(combined_text)

print(f"\n✅ Extracted {len(combined_text)} characters to: {txt_path}")

# ============================================================================
# STEP 2: PARSE THE EXTRACTED TEXT
# ============================================================================
print(f"\n{'='*80}")
print("PARSING EXTRACTED TEXT")
print("="*80)

# Read extracted text
with open(txt_path, 'r', encoding='utf-8') as f:
    lines = [line.rstrip() for line in f.readlines()]

print(f"\nTotal lines: {len(lines)}")

# Patterns
INVOICE_RE = re.compile(r'^([A-Za-z0-9]{3,8})-([A-Za-z0-9]{4,10})$')
MASTER_RE = re.compile(r'^Master\s+Occupant\s+Id:\s+(.+)$', re.I)
SUITE_RE = re.compile(r'^(?:Suite\s*Id:)?\s*(.+)$', re.I)
TOTAL_LINE_RE = re.compile(r'^(.+?)\s+Total:\s*(.*)$')
NUMBER_RE = re.compile(r'^[\-(),\d.]+$')

def clean_number(s):
    """Convert '-8,902.19' or '(123.45)' to float"""
    if not s or s == '':
        return 0.0
    s = s.strip()
    if s.startswith('(') and s.endswith(')'):
        return -float(s[1:-1].replace(',', ''))
    return float(s.replace(',', ''))

records = []
current_invoice = None
current_master = None
current_suite = None

i = 0
while i < len(lines):
    line = lines[i].strip()

    # Check for Invoice ID
    inv_match = INVOICE_RE.match(line)
    if inv_match:
        current_invoice = f"{inv_match.group(1)}-{inv_match.group(2)}"
        # Reset master and suite for new invoice
        current_master = None
        current_suite = None
        i += 1
        continue

    # Check for Master Occupant
    master_match = MASTER_RE.match(line)
    if master_match:
        current_master = master_match.group(1).strip()
        # Suite ID is typically on the next line after Master Occupant ID
        if i + 1 < len(lines):
            next_line = lines[i + 1].strip()
            # Check if next line looks like a suite ID (short alphanumeric, not a status keyword)
            if next_line and len(next_line) < 20 and next_line not in ['Current', 'Inactive', 'New', 'Day Due:', 'Delq Day:', 'Last Payment:', 'Contact:', 'Suite Id:', 'Status:']:
                # Additional check: should be alphanumeric with possible special chars
                if re.match(r'^[A-Za-z0-9/&\-\s]+$', next_line):
                    current_suite = next_line
        i += 1
        continue


    # Check for Total line
    total_match = TOTAL_LINE_RE.match(line)
    
    # Also check for orphan "Total:" (line contains only "Total:")
    is_orphan_total = line.strip() == "Total:"
    
    if total_match or is_orphan_total:
        if is_orphan_total:
            # Orphan "Total:" - find tenant name by looking backwards for invoice or tenant
            tenant = None
            # Look backwards for tenant name (before last invoice ID or category breakdown)
            for j in range(i - 1, max(0, i - 50), -1):
                prev_line = lines[j].strip()
                # Check if it's an invoice ID line
                inv_match = INVOICE_RE.match(prev_line)
                if inv_match:
                    # Found the invoice, now look forward for tenant name
                    for k in range(j + 1, min(len(lines), j + 10)):
                        potential_tenant = lines[k].strip()
                        # Skip known keywords
                        if potential_tenant and potential_tenant not in ['Contact:', 'Day Due:', 'Delq Day:', 'Last Payment:', 'Suite Id:', 'Status:', 'Current', 'Inactive', 'New'] and not INVOICE_RE.match(potential_tenant) and not potential_tenant.startswith('Master Occupant Id:'):
                            tenant = potential_tenant
                            break
                    break
            
            if not tenant:
                tenant = "UNKNOWN_ORPHAN"
            
            remaining = ""
        else:
            tenant = total_match.group(1).strip()
            remaining = total_match.group(2).strip()
        
        # Skip Grand Total
        if 'grand total' in tenant.lower():
            i += 1
            continue

        values = []

        # Case 1: First value on same line as "Total:" (e.g., "Total: -9,872.71")
        if remaining:
            # Extract the first number
            nums = re.findall(r'[\-(]?[\d,]+\.[\d]+\)?', remaining)
            if nums:
                try:
                    values.append(clean_number(nums[0]))
                except:
                    pass

        # Case 2: All values (or remaining values) on next lines
        # Start from next line after Total:
        for j in range(i + 1, min(i + 15, len(lines))):
            val_line = lines[j].strip()
            if NUMBER_RE.match(val_line):
                try:
                    values.append(clean_number(val_line))
                    if len(values) == 6:
                        break
                except:
                    pass
            elif val_line and not val_line.startswith(('0.', '-', '(', '1', '2', '3', '4', '5', '6', '7', '8', '9')):
                # Hit non-numeric text
                break

        # Create record if we have at least 4 values (flexible for different PDF formats)
        if len(values) >= 4:
            # Pad with 0.0 if we don't have all 6 values
            while len(values) < 6:
                values.append(0.0)

            records.append({
                "InvoiceID": current_invoice or "UNKNOWN",
                "Tenant": tenant,
                "MasterOccupantID": current_master,
                "SuiteID": current_suite,
                "Total": values[0],
                "Current": values[1],
                "Month_1": values[2],
                "Month_2": values[3],
                "Month_3": values[4],
                "Month_4": values[5],
            })

            if len(records) % 100 == 0:
                print(f"   Extracted {len(records)} records...")
        elif len(values) > 0:
            print(f"[WARNING] Only found {len(values)} values for: {tenant[:50]}")

    i += 1

print(f"\n{'='*80}")
print(f"EXTRACTION RESULTS:")
print(f"  Extracted: {len(records)} tenant records")
print(f"{'='*80}")

# Create DataFrame
df = pd.DataFrame(records)

# Show sample
print(f"\nFirst 10 records:")
print(df[['InvoiceID', 'Tenant', 'Total']].head(10).to_string(index=False))

print(f"\nLast 10 records:")
print(df[['InvoiceID', 'Tenant', 'Total']].tail(10).to_string(index=False))

# Save
df.to_excel(output_excel, index=False)
print(f"\n✅ Saved to: {output_excel}")

# Final summary
print(f"\nSUCCESS! Extracted {len(df)} tenant records from PDF!")
print("\n" + "="*80)



