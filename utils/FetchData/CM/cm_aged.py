import re
import time
import pandas as pd
from PyPDF2 import PdfReader
import sys
from pathlib import Path

_PROJECT_ROOT = Path(__file__).resolve().parents[3]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))
from utils.config_util import Config

# ---------- CONFIG ----------
start_time = time.time()
cfg = Config()
pdf_path = cfg.get("CM.AGED", "PDF")
output_excel = cfg.get("CM.AGED", "OccupantTotals")
report_excel_path = cfg.get("CM.AGED", "ReportExcel")
comparison_output_path = cfg.get("CM.AGED", "ComparisonResult")

# ---------- REGEX PATTERNS ----------
# OLD FORMAT: Status:M04900-001323 (invoice ID immediately after Status:)
# NEW FORMAT: Status: on one line, then 434b14-004864 on next line
# Combined pattern that handles both:
INVOICE_RE_OLD = re.compile(r'Status:\s*([A-Z][A-Za-z0-9]{2,6})[- ]([A-Za-z0-9]{4,8})')
INVOICE_RE_NEW = re.compile(r'Status:\s*$.*?^([a-zA-Z0-9]{3,6})[- ]([a-zA-Z0-9]{4,8})', re.MULTILINE)

MASTER_OCC_RE = re.compile(r'Master\s+Occupant\s+Id\s*[:\-]?\s*([0-9A-Za-z&/\s-]+?)(?=\s*(?:Current|Inactive|New|Day Due|Status|Suite|$))', re.IGNORECASE)
# Updated to capture suite IDs with special chars: 3/4, S1&S2, ST 36, 7N/S, D-4
SUITE_RE = re.compile(r'Suite\s*Id\s*[:\s]*([0-9A-Za-z/&\s-]+?)(?=\s*(?:Status|Current|Inactive|New|Day\s+Due|$))', re.IGNORECASE)
TOTAL_RE = re.compile(
    r'(.+?)\s+Total:\s*([\d,.-]+)\s*([\d,.-]+)\s*([\d,.-]+)\s*([\d,.-]+)\s*([\d,.-]+)\s*([\d,.-]+)',
    re.IGNORECASE
)

# ---------- READ PDF AS TEXT ----------
reader = PdfReader(pdf_path)
full_text = ""
for page in reader.pages:
    text = page.extract_text()
    if text:
        full_text += text + "\n"

# ---------- EXTRACT INVOICE BLOCKS ----------
invoice_blocks = []
lines = full_text.splitlines()
current_block = []
current_invoice_id = None

# Patterns:
# Both OLD and NEW formats have invoice ID on same line as "Status:"
# OLD: Status:M04900-001323 (uppercase start)
# NEW: Status:434b14-004864 (lowercase start)
INVOICE_PATTERN = re.compile(r'Status:\s*([A-Za-z0-9]{3,6})-([A-Za-z0-9]{4,9})\b', re.IGNORECASE)

for i, line in enumerate(lines):
    found_invoice = False
    invoice_id = None

    # Check for invoice ID pattern after "Status:"
    match = INVOICE_PATTERN.search(line)
    if match:
        invoice_id = f"{match.group(1)}-{match.group(2)}"
        found_invoice = True

    if found_invoice:
        # Save previous block
        if current_block and current_invoice_id:
            invoice_blocks.append((current_invoice_id, "\n".join(current_block)))
        current_block = [line]
        current_invoice_id = invoice_id
    elif current_invoice_id:
        current_block.append(line)

# Add last block
if current_block and current_invoice_id:
    invoice_blocks.append((current_invoice_id, "\n".join(current_block)))

print(f"[INFO] Extracted {len(invoice_blocks)} invoice blocks")
if len(invoice_blocks) > 0:
    print(f"[INFO] First 5 invoice IDs: {[inv_id for inv_id, _ in invoice_blocks[:5]]}")

# ---------- PROCESS BLOCKS ----------
records = []

for invoice_id, block in invoice_blocks:
    # Extract Master Occupant ID
    master_match = MASTER_OCC_RE.search(block)
    master_id = master_match.group(1).strip() if master_match else None

    # Extract Suite ID
    suite_match = SUITE_RE.search(block)
    suite_id = suite_match.group(1).strip() if suite_match else None

    # Extract Total line
    total_match = TOTAL_RE.search(block)
    if total_match:
        tenant_name = total_match.group(1).strip()
        totals = [float(total_match.group(i).replace(',', '')) for i in range(2, 8)]
        records.append({
            "InvoiceID": invoice_id,
            "Tenant": tenant_name,
            "MasterOccupantID": master_id,
            "SuiteID": suite_id,
            "Total": totals[0],
            "Current": totals[1],
            "Month_1": totals[2],
            "Month_2": totals[3],
            "Month_3": totals[4],
            "Month_4": totals[5],
        })
    else:
        print(f"[WARNING] Could not find totals in invoice {invoice_id}")

# ---------- SAVE TO EXCEL ----------
df = pd.DataFrame(records)
print(f"[INFO] Records in DataFrame before save: {len(df)}")
df.to_excel(output_excel, index=False)
print(f"[SAVED] Saved {len(df)} records to {output_excel}")

# ---------- Split MasterOccupantId and SuiteID ----------
df = pd.read_excel(output_excel)
print(f"[READ] Records read back from Excel: {len(df)}")

def split_master_suite(value):
    if pd.isna(value):
        return pd.NA, pd.NA
    try:
        left, right = value.split('-')
        master_id = f"{left}-{right[0]}"
        suite_id = right[1:]
        return master_id, suite_id
    except Exception:
        return pd.NA, pd.NA

df[['MasterOccupantID', 'SuiteID']] = df['MasterOccupantID'].apply(lambda x: pd.Series(split_master_suite(x)))

# Save updated Excel
print(f"[SAVE] Saving {len(df)} records after split processing...")
df.to_excel(output_excel, index=False)
print(f"[DONE] 'MasterOccupantID' and 'SuiteID' updated in {output_excel}")

# ---------- COMPARE EXCELS ----------
def compare_excels(extracted_path, report_path, output_path):
    numeric_cols = ["Total", "Current", "Month_1", "Month_2", "Month_3", "Month_4"]

    try:
        # Read both Excel files, IDs as strings
        df_extracted = pd.read_excel(extracted_path, dtype=str)
        df_report = pd.read_excel(report_path, dtype=str)

        # 🟢 Normalize column names
        df_extracted.columns = df_extracted.columns.str.strip()
        df_report.columns = df_report.columns.str.strip()

        # 🟢 Normalize Tenant for consistent matching
        for df in [df_extracted, df_report]:
            if "Tenant" in df.columns:
                df["Tenant"] = (
                    df["Tenant"]
                    .astype(str)
                    .str.strip()
                    .str.lower()
                    .str.replace(r"\s+", " ", regex=True)
                )

        # Convert numeric columns safely
        for col in numeric_cols:
            for df in [df_extracted, df_report]:
                if col in df.columns:
                    df[col] = pd.to_numeric(df[col], errors="coerce").fillna(0)

        # 🟢 Merge on Tenant instead of Invoice/Master/Suite
        merged = pd.merge(
            df_extracted,
            df_report,
            on=["Tenant"],
            how="outer",
            suffixes=("_extracted", "_report")
        )

        # Compare numeric columns
        for col in numeric_cols:
            merged[f"{col}_match"] = merged[f"{col}_extracted"].round(2) == merged[f"{col}_report"].round(2)

        # Overall match
        match_cols = [f"{c}_match" for c in numeric_cols]
        merged["Overall_Match"] = merged[match_cols].all(axis=1)

        # Save comparison
        with pd.ExcelWriter(output_path, engine="openpyxl") as writer:
            merged.to_excel(writer, index=False)

        print(f"Comparison saved -> {output_path}")

    except Exception as e:
        print(f"Comparison failed: {e}")

# Run comparison
compare_excels(output_excel, report_excel_path, comparison_output_path)

print(f"Total records extracted: {len(df)}")
print(f"Execution time: {round(time.time() - start_time, 2)}s")