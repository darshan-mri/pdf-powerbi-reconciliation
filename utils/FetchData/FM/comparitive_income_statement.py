# import re
# import pandas as pd
# from PyPDF2 import PdfReader
# from utils.config_util import Config
#
# # ---------- CONFIG ----------
# cfg = Config()
# pdf_path = cfg.get("FM.VARIANCE", "PDF")
# output_excel = cfg.get("FM.VARIANCE", "VarianceTotals")
#
# # ---------- MAPPING (Rename to friendly names) ----------
# RENAME_MAP = {
#     "[[N-N_RENT]]": "Rental Income",
#     "[[N-RCVINC]]": "Tenant Recharge Income",
#     "[[OTH_INC]]": "Other Income",
#     "[[IN-REV]]": "Total Income",
#     "[[N-RCV_OPEX]]": "Total Outgoing Expenses",
#     "[[N-NONRCV_OPEX]]": "Total Non Recoverable",
#     "[[N-NON_OPEX]]": "Non Operating Expenses",
#     "[[IN-OPEX]]": "Total Expenses",
#     "[[N-NOI]]": "Net Operating Income",
#     "[[OTH_EXP]]": "Other Expenses",
#     "[[N-CAPEX]]": "Total Capital Expenditures"
# }
#
# # ---------- READ PDF ----------
# reader = PdfReader(pdf_path)
# full_text = ""
# for page in reader.pages:
#     text = page.extract_text()
#     if text:
#         full_text += text + "\n"
#
# # ---------- REGEX TO CAPTURE LINES ----------
# LINE_RE = re.compile(r'\[\[(.*?)\]\]\s*(.+)', re.IGNORECASE)
# NUM_RE = re.compile(r'-?\(?\d[\d,]*\.?\d*\)?')  # match numbers and negatives
#
# records = []
# for line in full_text.splitlines():
#     match = LINE_RE.search(line)
#     if not match:
#         continue
#
#     code = f"[[{match.group(1)}]]"
#     label = RENAME_MAP.get(code, code)
#
#     # Extract all numeric tokens
#     nums = NUM_RE.findall(line)
#     # Convert to floats safely (remove commas, handle parentheses)
#     clean_nums = []
#     for n in nums:
#         n = n.replace(',', '').strip()
#         if n.startswith('(') and n.endswith(')'):
#             n = '-' + n[1:-1]
#         try:
#             clean_nums.append(float(n))
#         except ValueError:
#             continue
#
#     # Ensure 8 numeric values exist (fill missing with NaN)
#     while len(clean_nums) < 8:
#         clean_nums.append(pd.NA)
#     clean_nums = clean_nums[:8]  # trim any extras
#
#     record = {
#         "Code": code,
#         "Label": label,
#         "Actual MTD": clean_nums[0],
#         "Budget MTD": clean_nums[1],
#         "Variance MTD": clean_nums[2],
#         "Variance % MTD": clean_nums[3],
#         "Actual YTD": clean_nums[4],
#         "Budget YTD": clean_nums[5],
#         "Variance YTD": clean_nums[6],
#         "Variance % YTD": clean_nums[7],
#     }
#     records.append(record)
#
# # ---------- SAVE TO EXCEL ----------
# df = pd.DataFrame(records)
#
# df.to_excel(output_excel, index=False)
# print(f"✅ Extracted {len(df)} metrics with 8 numeric columns and saved to {output_excel}")


# # Final comparison script
# import pandas as pd
# from utils.config_util import Config
#
# # ---------- CONFIG ----------
# cfg = Config()
# variance_excel = cfg.get("FM.VARIANCE", "VarianceTotals")
# mtd_excel = cfg.get("FM.VARIANCE", "MTDReport")
# ytd_excel = cfg.get("FM.VARIANCE", "YTDReport")
# comparison_output = cfg.get("FM.VARIANCE", "ComparisonResult")
#
# # ---------- READ EXCELS ----------
# df_var = pd.read_excel(variance_excel)
# df_mtd = pd.read_excel(mtd_excel)
# df_ytd = pd.read_excel(ytd_excel)
#
# # ---------- CLEAN COLUMN NAMES ----------
# for df in [df_var, df_mtd, df_ytd]:
#     df.columns = df.columns.str.strip()
#
# # ---------- MERGE DATA ----------
# # Merge MTD report with variance MTD columns
# mtd_merge = pd.merge(
#     df_var[["Label", "Actual MTD", "Budget MTD", "Variance MTD", "Variance % MTD"]],
#     df_mtd,
#     on="Label",
#     how="outer",
#     suffixes=("_Extracted", "_Report")
# )
#
# # Merge YTD report with variance YTD columns
# ytd_merge = pd.merge(
#     df_var[["Label", "Actual YTD", "Budget YTD", "Variance YTD", "Variance % YTD"]],
#     df_ytd,
#     on="Label",
#     how="outer",
#     suffixes=("_Extracted", "_Report")
# )
#
# # ---------- CONVERT NUMERIC COLUMNS SAFELY ----------
# def safe_num(df, col):
#     if col in df.columns:
#         df[col] = pd.to_numeric(df[col], errors="coerce")
#     return df
#
# mtd_cols = [
#     "Actual MTD_Extracted", "Budget MTD_Extracted", "Variance MTD_Extracted", "Variance % MTD_Extracted",
#     "Actual MTD_Report", "Budget MTD_Report", "Variance MTD_Report", "Variance % MTD_Report"
# ]
# ytd_cols = [
#     "Actual YTD_Extracted", "Budget YTD_Extracted", "Variance YTD_Extracted", "Variance % YTD_Extracted",
#     "Actual YTD_Report", "Budget YTD_Report", "Variance YTD_Report", "Variance % YTD_Report"
# ]
#
# for col in mtd_cols + ytd_cols:
#     mtd_merge = safe_num(mtd_merge, col)
#     ytd_merge = safe_num(ytd_merge, col)
#
# # ---------- ADD MATCH COLUMNS ----------
# def add_comparisons(df, prefix):
#     df[f"{prefix}_Actual_Match"] = df[f"Actual {prefix}_Extracted"].round(2) == df[f"Actual {prefix}_Report"].round(2)
#     df[f"{prefix}_Budget_Match"] = df[f"Budget {prefix}_Extracted"].round(2) == df[f"Budget {prefix}_Report"].round(2)
#     df[f"{prefix}_Variance_Match"] = df[f"Variance {prefix}_Extracted"].round(2) == df[f"Variance {prefix}_Report"].round(2)
#     df[f"{prefix}_Variance%_Match"] = df[f"Variance % {prefix}_Extracted"].round(2) == df[f"Variance % {prefix}_Report"].round(2)
#     df[f"{prefix}_Overall_Match"] = df[
#         [f"{prefix}_Actual_Match", f"{prefix}_Budget_Match", f"{prefix}_Variance_Match", f"{prefix}_Variance%_Match"]
#     ].all(axis=1)
#     return df
#
# mtd_merge = add_comparisons(mtd_merge, "MTD")
# ytd_merge = add_comparisons(ytd_merge, "YTD")
#
# # ---------- COMBINE BOTH RESULTS ----------
# combined = pd.merge(
#     mtd_merge[["Label", "MTD_Overall_Match"]],
#     ytd_merge[["Label", "YTD_Overall_Match"]],
#     on="Label",
#     how="outer"
# )
# combined["Final_Result"] = combined[["MTD_Overall_Match", "YTD_Overall_Match"]].all(axis=1)
#
# # ---------- SAVE TO EXCEL ----------
# with pd.ExcelWriter(comparison_output, engine="openpyxl") as writer:
#     mtd_merge.to_excel(writer, index=False, sheet_name="MTD_Comparison")
#     ytd_merge.to_excel(writer, index=False, sheet_name="YTD_Comparison")
#     combined.to_excel(writer, index=False, sheet_name="Summary")
#
# print(f"✅ Comparison completed and saved to: {comparison_output}")


# # Final extraction script
# import re
# import pandas as pd
# import pdfplumber
# from utils.config_util import Config
#
# # ---------- CONFIG ----------
# cfg = Config()
# pdf_path = cfg.get("FM.VARIANCE", "PDF")
# output_excel = cfg.get("FM.VARIANCE", "VarianceTotals")
#
# RENAME_MAP = {
#     "[[N-N_RENT]]": "Rental Income",
#     "[[N-RCVINC]]": "Tenant Recharge Income",
#     "[[OTH_INC]]": "Other Income",
#     "[[IN-REV]]": "Total Income",
#     "[[N-RCV_OPEX]]": "Total Outgoing Expenses",
#     "[[N-NONRCV_OPEX]]": "Total Non Recoverable",
#     "[[N-NON_OPEX]]": "Non Operating Expenses",
#     "[[IN-OPEX]]": "Total Expenses",
#     "[[N-NOI]]": "Net Operating Income",
#     "[[OTH_EXP]]": "Other Expenses",
#     "[[N-CAPEX]]": "Total Capital Expenditures"
# }
#
# # ---------- HELPERS ----------
# NUM_RE = re.compile(r'\(?-?\d[\d,]*\.?\d*\)?%?')
#
# def to_float(tok: str):
#     tok = tok.replace(',', '').replace('%', '').strip()
#     if tok.startswith('(') and tok.endswith(')'):
#         tok = '-' + tok[1:-1]
#     try:
#         return float(tok)
#     except ValueError:
#         return pd.NA
#
# def extract_numeric_tokens(line: str):
#     """Return a list of cleaned floats found in a line."""
#     sanitized = re.sub(r'[A-Za-z\u00A0]+', '', line)
#     tokens = NUM_RE.findall(sanitized)
#     return [to_float(t) for t in tokens if t.strip()]
#
# def split_mtd_ytd(nums):
#     """Split numeric sequence into 8-value tuple."""
#     vals = [pd.NA] * 8
#     n = len(nums)
#     if n >= 8:
#         vals = nums[:8]
#     elif n == 7:
#         vals[:3], vals[4:] = nums[:3], nums[3:]
#     elif n == 6:
#         vals[:3], vals[4:7] = nums[:3], nums[3:]
#     elif n >= 3:
#         vals[:3] = nums[:3]
#         vals[4:4+len(nums[3:])] = nums[3:]
#     else:
#         vals[:n] = nums
#     return vals
#
# def merge_nearby_lines(lines, idx, lookahead=5):
#     """Combine line with next few lines if current has no numbers."""
#     combined = lines[idx]
#     nums = extract_numeric_tokens(combined)
#     if len(nums) >= 3:
#         return combined
#     for j in range(1, lookahead + 1):
#         if idx + j >= len(lines): break
#         nxt = lines[idx + j]
#         if "[[" in nxt and "]]" in nxt: break
#         nxt_nums = extract_numeric_tokens(nxt)
#         if len(nxt_nums) >= 3:
#             return combined + " " + nxt
#     return combined
#
# # ---------- EXTRACT ----------
# with pdfplumber.open(pdf_path) as pdf:
#     full_text = "\n".join([p.extract_text() or "" for p in pdf.pages])
#
# lines = [ln.strip() for ln in full_text.splitlines() if ln.strip()]
# records = []
# found_codes = set()
#
# for i, line in enumerate(lines):
#     m = re.search(r'\[\[(.*?)\]\]', line)
#     if not m:
#         continue
#
#     code = f"[[{m.group(1)}]]"
#     label = RENAME_MAP.get(code, code)
#     found_codes.add(code)
#
#     combined = merge_nearby_lines(lines, i)
#     nums = extract_numeric_tokens(combined)
#     vals = split_mtd_ytd(nums)
#
#     records.append({
#         "Code": code,
#         "Label": label,
#         "Actual MTD": vals[0],
#         "Budget MTD": vals[1],
#         "Variance MTD": vals[2],
#         "Variance % MTD": vals[3] if pd.notna(vals[3]) else 0,
#         "Actual YTD": vals[4],
#         "Budget YTD": vals[5],
#         "Variance YTD": vals[6],
#         "Variance % YTD": vals[7] if pd.notna(vals[7]) else 0
#     })
#
# # ---------- HANDLE MISSING CODES ----------
# missing = set(RENAME_MAP.keys()) - found_codes
# if missing:
#     for code in missing:
#         m = re.search(re.escape(code) + r".{0,200}", full_text)
#         if m:
#             snippet = m.group(0)
#             nums = extract_numeric_tokens(snippet)
#             vals = split_mtd_ytd(nums)
#             records.append({
#                 "Code": code,
#                 "Label": RENAME_MAP.get(code, code),
#                 "Actual MTD": vals[0],
#                 "Budget MTD": vals[1],
#                 "Variance MTD": vals[2],
#                 "Variance % MTD": vals[3],
#                 "Actual YTD": vals[4],
#                 "Budget YTD": vals[5],
#                 "Variance YTD": vals[6],
#                 "Variance % YTD": vals[7]
#             })
#
# # ---------- FINALIZE ----------
# df = pd.DataFrame(records)
# df["__order"] = df["Code"].apply(lambda c: list(RENAME_MAP.keys()).index(c) if c in RENAME_MAP else 999)
# df = df.sort_values("__order").drop(columns="__order")
#
# df.to_excel(output_excel, index=False)
# print(f"✅ Extracted {len(df)} rows and saved to {output_excel}")

import re
import pandas as pd
import pdfplumber
from utils.config_util import Config

# ---------- CONFIG ----------
cfg = Config()
pdf_path = cfg.get("FM.VARIANCE", "PDF")
variance_excel = cfg.get("FM.VARIANCE", "VarianceTotals")
mtd_excel = cfg.get("FM.VARIANCE", "MTDReport")
ytd_excel = cfg.get("FM.VARIANCE", "YTDReport")
comparison_output = cfg.get("FM.VARIANCE", "ComparisonResult")

# ---------- MAPPING ----------
RENAME_MAP = {
    "[[N-N_RENT]]": "Rental Income",
    "[[N-RCVINC]]": "Tenant Recharge Income",
    "[[OTH_INC]]": "Other Income",
    "[[IN-REV]]": "Total Income",
    "[[N-RCV_OPEX]]": "Total Outgoing Expenses",
    "[[N-NONRCV_OPEX]]": "Total Non Recoverable",
    "[[N-NON_OPEX]]": "Non Operating Expenses",
    "[[IN-OPEX]]": "Total Expenses",
    "[[N-NOI]]": "Net Operating Income",
    "[[OTH_EXP]]": "Other Expenses",
    "[[N-CAPEX]]": "Total Capital Expenditures"
}

# ---------- HELPERS ----------
NUM_RE = re.compile(r'\(?-?\d[\d,]*\.?\d*\)?%?')

def to_float(tok: str):
    tok = tok.replace(',', '').replace('%', '').strip()
    if tok.startswith('(') and tok.endswith(')'):
        tok = '-' + tok[1:-1]
    try:
        return float(tok)
    except ValueError:
        return pd.NA

def extract_numeric_tokens(line: str):
    """Return a list of cleaned floats found in a line."""
    sanitized = re.sub(r'[A-Za-z\u00A0]+', '', line)
    tokens = NUM_RE.findall(sanitized)
    return [to_float(t) for t in tokens if t.strip()]

def split_mtd_ytd(nums):
    """Split numeric sequence into 8-value tuple."""
    vals = [pd.NA] * 8
    n = len(nums)
    if n >= 8:
        vals = nums[:8]
    elif n == 7:
        vals[:3], vals[4:] = nums[:3], nums[3:]
    elif n == 6:
        vals[:3], vals[4:7] = nums[:3], nums[3:]
    elif n >= 3:
        vals[:3] = nums[:3]
        vals[4:4+len(nums[3:])] = nums[3:]
    else:
        vals[:n] = nums
    return vals

def merge_nearby_lines(lines, idx, lookahead=5):
    """Combine line with next few lines if current has no numbers."""
    combined = lines[idx]
    nums = extract_numeric_tokens(combined)
    if len(nums) >= 3:
        return combined
    for j in range(1, lookahead + 1):
        if idx + j >= len(lines): break
        nxt = lines[idx + j]
        if "[[" in nxt and "]]" in nxt: break
        nxt_nums = extract_numeric_tokens(nxt)
        if len(nxt_nums) >= 3:
            return combined + " " + nxt
    return combined

# ---------- STEP 1: PDF EXTRACTION ----------
with pdfplumber.open(pdf_path) as pdf:
    full_text = "\n".join([p.extract_text() or "" for p in pdf.pages])

lines = [ln.strip() for ln in full_text.splitlines() if ln.strip()]
records, found_codes = [], set()

for i, line in enumerate(lines):
    m = re.search(r'\[\[(.*?)\]\]', line)
    if not m:
        continue
    code = f"[[{m.group(1)}]]"
    label = RENAME_MAP.get(code, code)
    found_codes.add(code)

    combined = merge_nearby_lines(lines, i)
    nums = extract_numeric_tokens(combined)
    vals = split_mtd_ytd(nums)

    records.append({
        "Code": code,
        "Label": label,
        "Actual MTD": vals[0],
        "Budget MTD": vals[1],
        "Variance MTD": vals[2],
        "Variance % MTD": vals[3] if pd.notna(vals[3]) else 0,
        "Actual YTD": vals[4],
        "Budget YTD": vals[5],
        "Variance YTD": vals[6],
        "Variance % YTD": vals[7] if pd.notna(vals[7]) else 0
    })

# Handle missing codes
missing = set(RENAME_MAP.keys()) - found_codes
if missing:
    for code in missing:
        m = re.search(re.escape(code) + r".{0,200}", full_text)
        if m:
            snippet = m.group(0)
            nums = extract_numeric_tokens(snippet)
            vals = split_mtd_ytd(nums)
            records.append({
                "Code": code,
                "Label": RENAME_MAP.get(code, code),
                "Actual MTD": vals[0],
                "Budget MTD": vals[1],
                "Variance MTD": vals[2],
                "Variance % MTD": vals[3],
                "Actual YTD": vals[4],
                "Budget YTD": vals[5],
                "Variance YTD": vals[6],
                "Variance % YTD": vals[7]
            })

df_var = pd.DataFrame(records)
df_var["__order"] = df_var["Code"].apply(lambda c: list(RENAME_MAP.keys()).index(c) if c in RENAME_MAP else 999)
df_var = df_var.sort_values("__order").drop(columns="__order")
df_var.to_excel(variance_excel, index=False)
print(f"✅ Extracted {len(df_var)} rows and saved to {variance_excel}")

# ---------- STEP 2: COMPARISON ----------
df_mtd = pd.read_excel(mtd_excel)
df_ytd = pd.read_excel(ytd_excel)

for df in [df_var, df_mtd, df_ytd]:
    df.columns = df.columns.str.strip()

def safe_num(df, col):
    if col in df.columns:
        df[col] = pd.to_numeric(df[col], errors="coerce")
    return df

# Merge extracted with MTD report
mtd_merge = pd.merge(
    df_var[["Label", "Actual MTD", "Budget MTD", "Variance MTD", "Variance % MTD"]],
    df_mtd, on="Label", how="outer", suffixes=("_Extracted", "_Report")
)

# Merge extracted with YTD report
ytd_merge = pd.merge(
    df_var[["Label", "Actual YTD", "Budget YTD", "Variance YTD", "Variance % YTD"]],
    df_ytd, on="Label", how="outer", suffixes=("_Extracted", "_Report")
)

# Clean numeric columns
mtd_cols = [f"{c}_{s}" for c in ["Actual MTD", "Budget MTD", "Variance MTD", "Variance % MTD"] for s in ["Extracted", "Report"]]
ytd_cols = [f"{c}_{s}" for c in ["Actual YTD", "Budget YTD", "Variance YTD", "Variance % YTD"] for s in ["Extracted", "Report"]]
for col in mtd_cols + ytd_cols:
    mtd_merge = safe_num(mtd_merge, col)
    ytd_merge = safe_num(ytd_merge, col)

# Comparison function
def add_comparisons(df, prefix):
    df[f"{prefix}_Actual_Match"] = df[f"Actual {prefix}_Extracted"].round(2) == df[f"Actual {prefix}_Report"].round(2)
    df[f"{prefix}_Budget_Match"] = df[f"Budget {prefix}_Extracted"].round(2) == df[f"Budget {prefix}_Report"].round(2)
    df[f"{prefix}_Variance_Match"] = df[f"Variance {prefix}_Extracted"].round(2) == df[f"Variance {prefix}_Report"].round(2)
    df[f"{prefix}_Variance%_Match"] = df[f"Variance % {prefix}_Extracted"].round(2) == df[f"Variance % {prefix}_Report"].round(2)
    df[f"{prefix}_Overall_Match"] = df[
        [f"{prefix}_Actual_Match", f"{prefix}_Budget_Match", f"{prefix}_Variance_Match", f"{prefix}_Variance%_Match"]
    ].all(axis=1)
    return df

mtd_merge = add_comparisons(mtd_merge, "MTD")
ytd_merge = add_comparisons(ytd_merge, "YTD")

# Combine summaries
combined = pd.merge(
    mtd_merge[["Label", "MTD_Overall_Match"]],
    ytd_merge[["Label", "YTD_Overall_Match"]],
    on="Label", how="outer"
)
combined["Final_Result"] = combined[["MTD_Overall_Match", "YTD_Overall_Match"]].all(axis=1)

# ---------- SAVE ----------
with pd.ExcelWriter(comparison_output, engine="openpyxl") as writer:
    mtd_merge.to_excel(writer, index=False, sheet_name="MTD_Comparison")
    ytd_merge.to_excel(writer, index=False, sheet_name="YTD_Comparison")
    combined.to_excel(writer, index=False, sheet_name="Summary")

print(f"✅ Comparison completed and saved to {comparison_output}")




