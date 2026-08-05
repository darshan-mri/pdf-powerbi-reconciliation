"""
Parse AGED PDF using PyMuPDF extracted text
Handles both formats:
1. "Tenant Total:" on one line, then 6 values on next lines
2. "Tenant Total: value1 value2 ..." all on one line
"""
import re
import pandas as pd
import sys
from pathlib import Path
import fitz  # PyMuPDF

_PROJECT_ROOT = Path(__file__).resolve().parents[3]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))
from utils.config_util import Config

cfg = Config()
pdf_path = cfg.get("CM.AGED", "PDF")
txt_path = _PROJECT_ROOT / "files" / "excel" / "aged_pymupdf_layout.txt"
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
# Invoice ID must contain at least one letter in the first part (e.g., 312B01-003620, 344B01-001642, 434b14-004864)
# This excludes phone numbers like 347-8300, 546-6259 which are all digits
INVOICE_RE = re.compile(r'^([A-Za-z0-9]*[A-Za-z][A-Za-z0-9]*)-([A-Za-z0-9]{4,10})$')
# Phone number pattern to explicitly exclude (pure digits with dash or parentheses)
PHONE_RE = re.compile(r'^\(?\d{3}\)?[\s\-]?\d{3,4}[\s\-]?\d{4}$')
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

    # Skip phone numbers (they look like Invoice IDs but aren't)
    if PHONE_RE.match(line):
        i += 1
        continue

    # Check for Invoice ID
    inv_match = INVOICE_RE.match(line)
    if inv_match:
        # Additional validation: second part should contain at least one digit
        # This excludes company names like "Petro-Canada"
        second_part = inv_match.group(2)
        if re.search(r'\d', second_part):
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
print(f"  Extracted: {len(records)} tenant records (before deduplication)")
print(f"{'='*80}")

# Create DataFrame
df = pd.DataFrame(records)

# Remove duplicates based on InvoiceID (keep first occurrence)
initial_count = len(df)
df = df.drop_duplicates(subset=['InvoiceID'], keep='first')
duplicates_removed = initial_count - len(df)

if duplicates_removed > 0:
    print(f"\n⚠️  Removed {duplicates_removed} duplicate records")
    print(f"  Final count: {len(df)} unique tenant records")
else:
    print(f"\n✅ No duplicates found - {len(df)} unique records")

# Show sample
print(f"\nFirst 10 records:")
print(df[['InvoiceID', 'Tenant', 'Total']].head(10).to_string(index=False))

print(f"\nLast 10 records:")
print(df[['InvoiceID', 'Tenant', 'Total']].tail(10).to_string(index=False))

# Save
df.to_excel(output_excel, index=False)
print(f"\n✅ Saved to: {output_excel}")

# ============================================================================
# STEP 3: COMPARE WITH REPORT FILE
# ============================================================================
print(f"\n{'='*80}")
print("COMPARING WITH REPORT FILE")
print("="*80)

report_excel = cfg.get("CM.AGED", "ReportExcel")
comparison_output = cfg.get("CM.AGED", "ComparisonResult")

try:
    # Read report file
    df_report = pd.read_excel(report_excel)
    print(f"\n📊 Report File: {report_excel}")
    print(f"   Records: {len(df_report)}")

    # Transform report file
    print("\n🔄 Transforming report file...")

    # 1. Remove 'Lease & Building ID' column if it exists
    if 'Lease & Building ID' in df_report.columns:
        df_report = df_report.drop(columns=['Lease & Building ID'])
        print("   ✓ Removed 'Lease & Building ID' column")

    # 2. Combine BuildingID and LeaseID to create InvoiceID
    if 'BuildingID' in df_report.columns and 'LeaseID' in df_report.columns:
        # Convert LeaseID to string, handling NaN values
        df_report['LeaseID'] = df_report['LeaseID'].fillna(0).astype(int).astype(str).str.zfill(6)
        df_report['InvoiceID'] = df_report['BuildingID'].astype(str) + '-' + df_report['LeaseID']
        # Remove the original BuildingID and LeaseID columns
        df_report = df_report.drop(columns=['BuildingID', 'LeaseID'])
        print("   ✓ Created InvoiceID from BuildingID-LeaseID")

    # 3. Rename columns
    column_mapping = {
        'By Period Open Charges': 'Total',
        'By Period 1st Month Open Charges': 'Month_1',
        'By Period 2nd Month Open Charges': 'Month_2',
        'By Period 3rd Month Open Charges': 'Month_3',
        'By Period 4+ Months Open Charges': 'Month_4'
    }
    df_report = df_report.rename(columns=column_mapping)
    print("   ✓ Renamed financial columns")

    # Reorder columns to match extracted file
    available_cols = [col for col in ['InvoiceID', 'OccupantName', 'SuiteID', 'Total', 'Month_1', 'Month_2', 'Month_3', 'Month_4'] if col in df_report.columns]
    df_report = df_report[available_cols]

    print(f"\n{'='*80}")
    print("PERFORMING COMPARISON")
    print("="*80)

    # Comparison based on InvoiceID
    print(f"\n📋 Extracted Records: {len(df)}")
    print(f"📋 Report Records: {len(df_report)}")

    # Merge on InvoiceID to compare records with same InvoiceID
    comparison = df.merge(
        df_report,
        on='InvoiceID',
        how='outer',
        suffixes=('_Extracted', '_Report'),
        indicator=True
    )

    # Add Status column to track record source and matching status
    def determine_status(row):
        threshold = 0.01

        if row['_merge'] == 'left_only':
            return 'Missing in Report'
        elif row['_merge'] == 'right_only':
            return 'Missing in Extraction'
        else:  # both
            # Check if values match
            if pd.notna(row['Total_Extracted']) and pd.notna(row['Total_Report']):
                if abs(row['Total_Extracted'] - row['Total_Report']) <= threshold:
                    return 'Match'
                else:
                    return 'Value Mismatch'
            else:
                return 'Match (with nulls)'

    # Calculate differences for financial columns (only for records in both)
    financial_cols = ['Total', 'Month_1', 'Month_2', 'Month_3', 'Month_4']
    for col in financial_cols:
        col_ext = f"{col}_Extracted"
        col_rep = f"{col}_Report"
        if col_ext in comparison.columns and col_rep in comparison.columns:
            # Fill NaN with 0 for calculation
            comparison[f"{col}_Diff"] = comparison[col_ext].fillna(0) - comparison[col_rep].fillna(0)
            # Set diff to NaN where either value is missing
            comparison.loc[comparison['_merge'] != 'both', f"{col}_Diff"] = pd.NA

    # Add Status column
    comparison['Status'] = comparison.apply(determine_status, axis=1)

    # Reorder columns to put Status near the beginning
    cols = comparison.columns.tolist()
    # Move Status after InvoiceID
    cols.remove('Status')
    invoice_idx = cols.index('InvoiceID')
    cols.insert(invoice_idx + 1, 'Status')
    comparison = comparison[cols]

    # Categorize records
    in_both = comparison[comparison['_merge'] == 'both']
    only_extracted = comparison[comparison['_merge'] == 'left_only']
    only_report = comparison[comparison['_merge'] == 'right_only']

    # Further categorize matched records
    matches = comparison[comparison['Status'] == 'Match']
    mismatches = comparison[comparison['Status'] == 'Value Mismatch']

    print(f"\n✓ Records in Both Files: {len(in_both)}")
    print(f"   • Perfect Matches: {len(matches)}")
    print(f"   • Value Mismatches: {len(mismatches)}")
    print(f"⚠ Missing in Report: {len(only_extracted)}")
    print(f"⚠ Missing in Extraction: {len(only_report)}")

    # Check for differences in matching records
    threshold = 0.01  # $0.01 threshold for differences
    if len(mismatches) > 0:
        print(f"\n⚠ Records with Total differences (>${threshold}): {len(mismatches)}")

    # Save comparison results
    comparison.to_excel(comparison_output, index=False)
    print(f"\n✅ Comparison saved to: {comparison_output}")

    # Display summary statistics
    print(f"\n{'='*80}")
    print("COMPARISON SUMMARY")
    print("="*80)
    print(f"Total Records Compared: {len(comparison)}")
    print(f"\nBy Status:")
    print(f"  ✅ Perfect Matches: {len(matches)} ({len(matches)/len(comparison)*100:.1f}%)")
    print(f"  ⚠️  Value Mismatches: {len(mismatches)} ({len(mismatches)/len(comparison)*100:.1f}%)")
    print(f"  ❌ Missing in Report: {len(only_extracted)} ({len(only_extracted)/len(comparison)*100:.1f}%)")
    print(f"  ❌ Missing in Extraction: {len(only_report)} ({len(only_report)/len(comparison)*100:.1f}%)")

    if len(in_both) > 0:
        match_rate = len(matches) / len(in_both) * 100
        print(f"\nValue Match Rate (for records in both): {match_rate:.1f}%")

        # Show sample of differences if any
        if len(mismatches) > 0:
            print(f"\nSample Records with Value Mismatches (first 5):")
            display_cols = ['InvoiceID', 'Status', 'Tenant', 'Total_Extracted', 'Total_Report', 'Total_Diff']
            print(mismatches[display_cols].head().to_string(index=False))

    # Show samples of missing records
    if len(only_extracted) > 0:
        print(f"\nSample Records Missing in Report (first 5):")
        missing_cols = ['InvoiceID', 'Status', 'Tenant', 'Total_Extracted']
        print(only_extracted[missing_cols].head().to_string(index=False))

    if len(only_report) > 0:
        print(f"\nSample Records Missing in Extraction (first 5):")
        missing_report_cols = ['InvoiceID', 'Status', 'OccupantName', 'Total_Report']
        print(only_report[missing_report_cols].head().to_string(index=False))

    print("\n" + "="*80)

except FileNotFoundError:
    print(f"\n⚠ Report file not found: {report_excel}")
    print("   Skipping comparison.")
except Exception as e:
    print(f"\n⚠ Error during comparison: {e}")
    print("   Extraction completed successfully, but comparison failed.")

# Final summary
print(f"\n🎉 SUCCESS! Extracted {len(df)} tenant records from PDF!")
if 'comparison' in locals():
    print(f"✅ Comparison completed with report file")
print("\n" + "="*80)



