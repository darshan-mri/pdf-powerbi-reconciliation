#Final working version
# import re
# import time
# import pandas as pd
# from PyPDF2 import PdfReader
# from utils.config_util import Config
#
# # ---------- CONFIG ----------
# start_time = time.time()
# cfg = Config()
# pdf_path = cfg.get("CM.AGED", "PDF")
# output_excel = cfg.get("CM.AGED", "OccupantTotals")
#
# # ---------- REGEX PATTERNS ----------
# INVOICE_RE = re.compile(r'(\d{4})[- ](\d{6})')
# MASTER_OCC_RE = re.compile(r'Master\s+Occupant\s+Id\s*[:\-]?\s*([0-9A-Za-z-]+)', re.IGNORECASE)
# SUITE_RE = re.compile(r'Suite\s*(?:Id|#|No\.?)?[:\s]*([0-9A-Za-z-]+)', re.IGNORECASE)
# TOTAL_RE = re.compile(
#     r'(.+?)\s+Total:\s*([\d,.-]+)\s*([\d,.-]+)\s*([\d,.-]+)\s*([\d,.-]+)\s*([\d,.-]+)\s*([\d,.-]+)',
#     re.IGNORECASE
# )
#
# # ---------- READ PDF AS TEXT ----------
# reader = PdfReader(pdf_path)
# full_text = ""
# for page in reader.pages:
#     text = page.extract_text()
#     if text:
#         full_text += text + "\n"
#
# # ---------- EXTRACT INVOICE BLOCKS ----------
# # We'll split text into blocks by detecting invoice IDs
# invoice_blocks = []
# lines = full_text.splitlines()
# current_block = []
#
# for line in lines:
#     if INVOICE_RE.search(line):
#         if current_block:
#             invoice_blocks.append("\n".join(current_block))
#         current_block = [line]
#     else:
#         current_block.append(line)
#
# # add last block
# if current_block:
#     invoice_blocks.append("\n".join(current_block))
#
# # ---------- PROCESS BLOCKS ----------
# records = []
#
# for block in invoice_blocks:
#     # Invoice ID
#     inv_match = INVOICE_RE.search(block)
#     invoice_id = f"{inv_match.group(1)}-{inv_match.group(2)}" if inv_match else None
#
#     # Master Occupant ID
#     master_match = MASTER_OCC_RE.search(block)
#     master_id = master_match.group(1) if master_match else None
#
#     # Suite ID
#     suite_match = SUITE_RE.search(block)
#     suite_id = suite_match.group(1) if suite_match else None
#
#     # Tenant Name and Totals
#     total_match = TOTAL_RE.search(block)
#     if total_match:
#         tenant_name = total_match.group(1).strip()
#         totals = [float(total_match.group(i).replace(',', '')) for i in range(2, 8)]
#         records.append({
#             "InvoiceID": invoice_id,
#             "Tenant": tenant_name,
#             "MasterOccupantID": master_id,
#             "SuiteID": suite_id,
#             "Total": totals[0],
#             "Current": totals[1],
#             "Month_1": totals[2],
#             "Month_2": totals[3],
#             "Month_3": totals[4],
#             "Month_4": totals[5],
#         })
#     else:
#         print(f"⚠️ Could not find totals in invoice {invoice_id}")
#
# # ---------- SAVE TO EXCEL ----------
# df = pd.DataFrame(records)
# df.to_excel(output_excel, index=False)
#
# # ---------- Split MasterOccupantId and SuiteID ----------
# df = pd.read_excel(output_excel)
#
# # Function to split the value
# def split_master_suite(value):
#     if pd.isna(value):
#         return pd.NA, pd.NA
#     try:
#         left, right = value.split('-')
#         # Master OccupantId -> left + first digit of right
#         master_id = f"{left}-{right[0]}"
#         # SuiteId -> remaining digits of right
#         suite_id = right[1:]
#         return master_id, suite_id
#     except Exception as e:
#         return pd.NA, pd.NA
#
# # Apply the function
# df[['MasterOccupantID', 'SuiteID']] = df['MasterOccupantID'].apply(lambda x: pd.Series(split_master_suite(x)))
#
# # Save to new Excel
# df.to_excel(output_excel, index=False)
#
# print(f"Done! 'Master Occupant Id' and 'SuiteID' updated in {output_excel}")
#
# print(f"Excel file saved: {output_excel}")
# print(f"Total records extracted: {len(df)}")
# print(f"Execution time: {round(time.time() - start_time, 2)}s")

#Final version with comparison
# import re
# import time
# import pandas as pd
# from PyPDF2 import PdfReader
# from utils.config_util import Config
#
# # ---------- CONFIG ----------
# start_time = time.time()
# cfg = Config()
# pdf_path = cfg.get("CM.AGED", "PDF")
# output_excel = cfg.get("CM.AGED", "OccupantTotals")
# report_excel_path = cfg.get("CM.AGED", "ReportExcel")
# comparison_output_path = cfg.get("CM.AGED", "ComparisonResult")
#
# # ---------- REGEX PATTERNS ----------
# INVOICE_RE = re.compile(r'(\d{4})[- ](\d{6})')
# MASTER_OCC_RE = re.compile(r'Master\s+Occupant\s+Id\s*[:\-]?\s*([0-9A-Za-z-]+)', re.IGNORECASE)
# SUITE_RE = re.compile(r'Suite\s*(?:Id|#|No\.?)?[:\s]*([0-9A-Za-z-]+)', re.IGNORECASE)
# TOTAL_RE = re.compile(
#     r'(.+?)\s+Total:\s*([\d,.-]+)\s*([\d,.-]+)\s*([\d,.-]+)\s*([\d,.-]+)\s*([\d,.-]+)\s*([\d,.-]+)',
#     re.IGNORECASE
# )
#
# # ---------- READ PDF AS TEXT ----------
# reader = PdfReader(pdf_path)
# full_text = ""
# for page in reader.pages:
#     text = page.extract_text()
#     if text:
#         full_text += text + "\n"
#
# # ---------- EXTRACT INVOICE BLOCKS ----------
# invoice_blocks = []
# lines = full_text.splitlines()
# current_block = []
#
# for line in lines:
#     if INVOICE_RE.search(line):
#         if current_block:
#             invoice_blocks.append("\n".join(current_block))
#         current_block = [line]
#     else:
#         current_block.append(line)
#
# # add last block
# if current_block:
#     invoice_blocks.append("\n".join(current_block))
#
# # ---------- PROCESS BLOCKS ----------
# records = []
#
# for block in invoice_blocks:
#     inv_match = INVOICE_RE.search(block)
#     invoice_id = f"{inv_match.group(1)}-{inv_match.group(2)}" if inv_match else None
#
#     master_match = MASTER_OCC_RE.search(block)
#     master_id = master_match.group(1) if master_match else None
#
#     suite_match = SUITE_RE.search(block)
#     suite_id = suite_match.group(1) if suite_match else None
#
#     total_match = TOTAL_RE.search(block)
#     if total_match:
#         tenant_name = total_match.group(1).strip()
#         totals = [float(total_match.group(i).replace(',', '')) for i in range(2, 8)]
#         records.append({
#             "InvoiceID": invoice_id,
#             "Tenant": tenant_name,
#             "MasterOccupantID": master_id,
#             "SuiteID": suite_id,
#             "Total": totals[0],
#             "Current": totals[1],
#             "Month_1": totals[2],
#             "Month_2": totals[3],
#             "Month_3": totals[4],
#             "Month_4": totals[5],
#         })
#     else:
#         print(f"⚠️ Could not find totals in invoice {invoice_id}")
#
# # ---------- SAVE TO EXCEL ----------
# df = pd.DataFrame(records)
# df.to_excel(output_excel, index=False)
#
# # ---------- Split MasterOccupantId and SuiteID ----------
# df = pd.read_excel(output_excel)
#
# def split_master_suite(value):
#     if pd.isna(value):
#         return pd.NA, pd.NA
#     try:
#         left, right = value.split('-')
#         master_id = f"{left}-{right[0]}"
#         suite_id = right[1:]
#         return master_id, suite_id
#     except Exception:
#         return pd.NA, pd.NA
#
# df[['MasterOccupantID', 'SuiteID']] = df['MasterOccupantID'].apply(lambda x: pd.Series(split_master_suite(x)))
#
# # Save updated Excel
# df.to_excel(output_excel, index=False)
# print(f"Done! 'MasterOccupantID' and 'SuiteID' updated in {output_excel}")
#
# # ---------- COMPARE EXCELS ----------
# def compare_excels(extracted_path, report_path, output_path):
#     numeric_cols = ["Total", "Current", "Month_1", "Month_2", "Month_3", "Month_4"]
#
#     try:
#         # Read both Excel files, IDs as strings
#         df_extracted = pd.read_excel(extracted_path, dtype=str)
#         df_report = pd.read_excel(report_path, dtype=str)
#
#         # Convert numeric columns safely
#         for col in numeric_cols:
#             for df in [df_extracted, df_report]:
#                 if col in df.columns:
#                     df[col] = pd.to_numeric(df[col], errors="coerce").fillna(0)
#
#         # Normalize column names
#         df_extracted.columns = df_extracted.columns.str.strip()
#         df_report.columns = df_report.columns.str.strip()
#
#         # Merge on IDs
#         merged = pd.merge(
#             df_extracted,
#             df_report,
#             on=["InvoiceID", "MasterOccupantID", "SuiteID"],
#             how="outer",
#             suffixes=("_extracted", "_report")
#         )
#
#         # Compare numeric columns
#         for col in numeric_cols:
#             merged[f"{col}_match"] = merged[f"{col}_extracted"].round(2) == merged[f"{col}_report"].round(2)
#
#         # Overall match
#         match_cols = [f"{c}_match" for c in numeric_cols]
#         merged["Overall_Match"] = merged[match_cols].all(axis=1)
#
#         # Save comparison
#         with pd.ExcelWriter(output_path, engine="openpyxl") as writer:
#             merged.to_excel(writer, index=False)
#
#         print(f"Comparison saved -> {output_path}")
#
#     except Exception as e:
#         print(f"Comparison failed: {e}")
#
# # Run comparison
# compare_excels(output_excel, report_excel_path, comparison_output_path)
#
# print(f"Total records extracted: {len(df)}")
# print(f"Execution time: {round(time.time() - start_time, 2)}s")

import re
import time
import pandas as pd
from PyPDF2 import PdfReader
from utils.config_util import Config

# ---------- CONFIG ----------
start_time = time.time()
cfg = Config()
pdf_path = cfg.get("CM.AGED", "PDF")
output_excel = cfg.get("CM.AGED", "OccupantTotals")
report_excel_path = cfg.get("CM.AGED", "ReportExcel")
comparison_output_path = cfg.get("CM.AGED", "ComparisonResult")

# ---------- REGEX PATTERNS ----------
INVOICE_RE = re.compile(r'(\d{4})[- ](\d{6})')
MASTER_OCC_RE = re.compile(r'Master\s+Occupant\s+Id\s*[:\-]?\s*([0-9A-Za-z-]+)', re.IGNORECASE)
SUITE_RE = re.compile(r'Suite\s*(?:Id|#|No\.?)?[:\s]*([0-9A-Za-z-]+)', re.IGNORECASE)
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

for line in lines:
    if INVOICE_RE.search(line):
        if current_block:
            invoice_blocks.append("\n".join(current_block))
        current_block = [line]
    else:
        current_block.append(line)

# Add last block
if current_block:
    invoice_blocks.append("\n".join(current_block))

# ---------- PROCESS BLOCKS ----------
records = []

for block in invoice_blocks:
    inv_match = INVOICE_RE.search(block)
    invoice_id = f"{inv_match.group(1)}-{inv_match.group(2)}" if inv_match else None

    master_match = MASTER_OCC_RE.search(block)
    master_id = master_match.group(1) if master_match else None

    suite_match = SUITE_RE.search(block)
    suite_id = suite_match.group(1) if suite_match else None

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
        print(f"⚠️ Could not find totals in invoice {invoice_id}")

# ---------- SAVE TO EXCEL ----------
df = pd.DataFrame(records)
df.to_excel(output_excel, index=False)

# ---------- Split MasterOccupantId and SuiteID ----------
df = pd.read_excel(output_excel)

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
df.to_excel(output_excel, index=False)
print(f"Done! 'MasterOccupantID' and 'SuiteID' updated in {output_excel}")

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

