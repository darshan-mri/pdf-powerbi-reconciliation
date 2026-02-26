# # extract_totals_with_building_lease.py
# import re
# import time
# import pdfplumber
# import pandas as pd
# from utils.config_util import Config
# import os
#
# # ------------------ NUMERIC CLEANING ------------------
#
# def _clean_num_token(tok: str):
#     t = tok.replace(',', '').strip()
#     if t.startswith('(') and t.endswith(')'):
#         t = '-' + t[1:-1]
#     try:
#         return float(t)
#     except Exception:
#         return None
#
# # ------------------ LEDGER TYPE DETECTION ------------------
#
# def detect_ledger_type(pdf_path: str) -> str:
#     filename = os.path.basename(pdf_path).upper()
#     if "-APAC" in filename:
#         return "APAC"
#     elif "-US" in filename:
#         return "US"
#     else:
#         return "UNKNOWN"
#
# # ===================== US Extraction Logic =====================
#
# NUM_RE_US = re.compile(r'\(?-?\d[\d,]*\.?\d*\)?')
# LEASE_HEADER_RE_US = re.compile(r'(\d{4})[- ](\d{6})')
#
# def group_words_to_lines(words, y_tol=3.0):
#     if not words:
#         return []
#     words_sorted = sorted(words, key=lambda w: (w['top'], w['x0']))
#     lines, cur_line, cur_top = [], [], words_sorted[0]['top']
#     for w in words_sorted:
#         if abs(w['top'] - cur_top) <= y_tol:
#             cur_line.append(w)
#         else:
#             lines.append(cur_line)
#             cur_line = [w]
#             cur_top = w['top']
#     if cur_line:
#         lines.append(cur_line)
#     return lines
#
# def _parse_number_token(raw: str):
#     txt = raw.strip()
#     neg = txt.startswith('(') and txt.endswith(')')
#     core = txt[1:-1] if neg else txt
#     try:
#         val = float(core.replace(',', ''))
#         return -val if neg else val
#     except ValueError:
#         return None
#
# def numeric_center_map(line_words):
#     entries = []
#     for w in line_words:
#         m = NUM_RE_US.search(w['text'])
#         if not m:
#             continue
#         raw = m.group(0)
#         val = _parse_number_token(raw)
#         if val is None:
#             continue
#         center = (w['x0'] + w['x1']) / 2.0
#         entries.append((val, center, w['text']))
#     entries.sort(key=lambda e: e[1])
#     return entries
#
# def _pick_charges_cash_US(nums_vals):
#     charges = nums_vals[2] if len(nums_vals) >= 3 else None
#     cash = nums_vals[3] if len(nums_vals) >= 4 else None
#     return charges, cash
#
# def _is_building_total_US(lower_line: str) -> bool:
#     if "grand" in lower_line:
#         return False
#     if "totals for" in lower_line:
#         return True
#     if "bldg" in lower_line and "total" in lower_line:
#         return True
#     if "building total" in lower_line:
#         return True
#     return False
#
# def extract_totals_with_ids_US(pdf_path):
#     lease_rows, bldg_rows = [], []
#     current_building, current_lease = None, None
#
#     with pdfplumber.open(pdf_path) as pdf:
#         for page in pdf.pages:
#             words = page.extract_words()
#             lines = group_words_to_lines(words, y_tol=3.0)
#
#             for line_words in lines:
#                 line_text = " ".join(w['text'] for w in line_words).strip()
#                 lower = line_text.lower()
#
#                 lease_match = LEASE_HEADER_RE_US.search(line_text)
#                 if lease_match:
#                     current_building = lease_match.group(1).zfill(4)
#                     current_lease = lease_match.group(2).zfill(6)
#
#                 is_lease_total = lower.startswith("total:")
#                 is_bldg_total = _is_building_total_US(lower)
#
#                 if not (is_lease_total or is_bldg_total):
#                     continue
#
#                 nums = numeric_center_map(line_words)
#                 if not nums:
#                     continue
#                 nums_vals = [t[0] for t in nums]
#
#                 charges_val, cash_val = _pick_charges_cash_US(nums_vals)
#
#                 if is_lease_total:
#                     lease_rows.append({
#                         "building": current_building,
#                         "lease": current_lease,
#                         "charges": charges_val,
#                         "cash_receipts": cash_val
#                     })
#                 elif is_bldg_total:
#                     bldg_rows.append({
#                         "building": current_building,
#                         "charges": charges_val,
#                         "cash_receipts": cash_val
#                     })
#
#     df_lease = pd.DataFrame(lease_rows, columns=["building", "lease", "charges", "cash_receipts"])
#     df_bldg = pd.DataFrame(bldg_rows, columns=["building", "charges", "cash_receipts"])
#     df_lease = df_lease.astype({"building": "string", "lease": "string"})
#     df_bldg = df_bldg.astype({"building": "string"})
#     return df_lease, df_bldg
#
# # ===================== APAC Extraction Logic =====================
#
# NUM_RE_APAC = re.compile(r'-?\(?\d[\d,]*\.?\d*\)?')
# LEASE_HEADER_RE_APAC = re.compile(r'(\d{3,6})[\s-]+(\d{5,6})')
# BLDG_RE_APAC = re.compile(r'\(bldg[:\s]*([0-9]+)\)', re.I)
# IGNORE_PATTERNS = re.compile(
#     r'(mo\.?\s*rep|beg\s*balance|end\s*balance|sec\s*dep|prior\s*balance|opening\s*balance)',
#     re.I
# )
#
# def parse_total_line_APAC(line: str, is_bldg_total: bool = False):
#     nums = [_clean_num_token(x) for x in re.findall(NUM_RE_APAC, line)]
#     nums = [n for n in nums if n is not None]
#     if not nums:
#         return 0.0, 0.0
#
#     charges, cash = 0.0, 0.0
#
#     if len(nums) >= 4:
#         charges = nums[2]
#         cash = nums[3]
#     else:
#         charges_idx = max(range(len(nums)), key=lambda i: abs(nums[i]))
#         charges = nums[charges_idx]
#         cash = nums[charges_idx + 1] if charges_idx + 1 < len(nums) else 0.0
#
#     return charges, cash
#
# def _is_building_total_APAC(lower_line: str, prev_line: str | None = None) -> bool:
#     if not lower_line.strip() or "grand" in lower_line:
#         return False
#
#     patterns = [
#         r'\b(bldg|building)\b.*total',
#         r'totals?\s+for\s+(bldg|building)',
#         r'\bproperty\b.*total',
#         r'\bbuilding\s*\d+\b',
#     ]
#     for pat in patterns:
#         if re.search(pat, lower_line, re.I):
#             return True
#
#     if prev_line and ('bldg' in prev_line.lower() or 'building' in prev_line.lower()) and "total" in lower_line:
#         return True
#
#     return False
#
# def extract_totals_with_ids_APAC(pdf_path):
#     lease_rows, bldg_rows = [], []
#     current_building, current_lease = None, None
#     last_line_text = ""
#     last_bldg_seen = None
#
#     with pdfplumber.open(pdf_path) as pdf:
#         for page_num, page in enumerate(pdf.pages, start=1):
#             words = page.extract_words()
#             lines = group_words_to_lines(words, y_tol=3.0)
#
#             for line_words in lines:
#                 line_text = " ".join(w['text'] for w in line_words).strip()
#                 if not line_text or IGNORE_PATTERNS.search(line_text):
#                     continue
#
#                 lower = line_text.lower()
#                 lease_match = LEASE_HEADER_RE_APAC.search(line_text)
#                 if lease_match:
#                     current_building = lease_match.group(1).zfill(4)
#                     current_lease = lease_match.group(2).zfill(6)
#                     last_bldg_seen = current_building
#
#                 bldg_match = BLDG_RE_APAC.search(line_text)
#                 if bldg_match:
#                     current_building = bldg_match.group(1).zfill(6)
#                     last_bldg_seen = current_building
#
#                 is_lease_total = lower.startswith("total:")
#                 is_bldg_total = _is_building_total_APAC(lower, last_line_text)
#
#                 if is_lease_total or is_bldg_total:
#                     charges, cash = parse_total_line_APAC(
#                         line_text,
#                         is_bldg_total=is_bldg_total
#                     )
#
#                     if is_lease_total:
#                         lease_rows.append({
#                             "building": current_building or last_bldg_seen,
#                             "lease": current_lease,
#                             "charges": charges,
#                             "cash_receipts": cash
#                         })
#                     elif is_bldg_total:
#                         bldg_rows.append({
#                             "building": current_building or last_bldg_seen,
#                             "charges": charges,
#                             "cash_receipts": cash
#                         })
#
#                 last_line_text = line_text
#
#     df_lease = pd.DataFrame(lease_rows, columns=["building", "lease", "charges", "cash_receipts"])
#     df_bldg = pd.DataFrame(bldg_rows, columns=["building", "charges", "cash_receipts"])
#     df_lease = df_lease.astype({"building": "string", "lease": "string"})
#     df_bldg = df_bldg.astype({"building": "string"})
#     return df_lease, df_bldg
#
# # ===================== EXCEL COMPARISON =====================
#
# def compare_excels(extracted_path, report_path, output_path):
#     try:
#         df_extracted = pd.read_excel(extracted_path, sheet_name="LeaseTotals", dtype=str)
#         df_report = pd.read_excel(report_path, dtype=str)
#
#         for col in ["charges", "cash_receipts"]:
#             for df in [df_extracted, df_report]:
#                 if col in df.columns:
#                     df[col] = pd.to_numeric(df[col], errors="coerce").fillna(0)
#
#         df_extracted.columns = df_extracted.columns.str.strip().str.lower()
#         df_report.columns = df_report.columns.str.strip().str.lower()
#
#         merged = pd.merge(
#             df_extracted,
#             df_report,
#             on=["building", "lease"],
#             how="outer",
#             suffixes=("_extracted", "_report")
#         )
#
#         merged["charges_match"] = (
#             merged["charges_extracted"].round(2) == merged["charges_report"].round(2)
#         )
#         merged["cash_match"] = (
#             merged["cash_receipts_extracted"].round(2) == merged["cash_receipts_report"].round(2)
#         )
#         merged["Overall_Match"] = merged["charges_match"] & merged["cash_match"]
#
#         merged["building"] = merged["building"].astype(str).str.zfill(4)
#         merged["lease"] = merged["lease"].astype(str).str.zfill(6)
#
#         with pd.ExcelWriter(output_path, engine="openpyxl") as writer:
#             merged.to_excel(writer, index=False)
#         print(f"Comparison saved -> {output_path}")
#
#     except Exception as e:
#         print(f"Comparison failed: {e}")
#
# # ===================== MAIN =====================
#
# if __name__ == "__main__":
#     start_time = time.time()
#     config = Config()
#     pdf_path = config.get("CM.LEDGER", "PDF")
#     ledgers_totals_path = config.get("CM.LEDGER", "LedgerTotals")
#     report_excel_path = config.get("CM.LEDGER", "ReportExcel")
#     comparison_output_path = config.get("CM.LEDGER", "ComparisonResult")
#
#     ledger_type = detect_ledger_type(pdf_path)
#     print(f"📘 Detected Ledger Type: {ledger_type}")
#
#     if ledger_type == "US":
#         df_lease, df_bldg = extract_totals_with_ids_US(pdf_path)
#     elif ledger_type == "APAC":
#         df_lease, df_bldg = extract_totals_with_ids_APAC(pdf_path)
#     else:
#         raise ValueError(f"Unknown ledger type for {pdf_path}")
#
#     # Save extraction
#     if df_lease.empty:
#         df_lease = pd.DataFrame(columns=["building", "lease", "charges", "cash_receipts"])
#     if df_bldg.empty:
#         df_bldg = pd.DataFrame(columns=["building", "charges", "cash_receipts"])
#
#     with pd.ExcelWriter(ledgers_totals_path, engine="openpyxl") as writer:
#         df_lease.to_excel(writer, sheet_name="LeaseTotals", index=False, float_format="%.2f")
#         df_bldg.to_excel(writer, sheet_name="BldgTotals", index=False, float_format="%.2f")
#
#     print(f"\n✅ Extracted totals saved -> {ledgers_totals_path}")
#
#     # Compare against report Excel
#     compare_excels(ledgers_totals_path, report_excel_path, comparison_output_path)
#
#     print(f"⚙ Execution time: {round(time.time() - start_time, 2)}s")




#---------New Script---------------
import re
import time
import pdfplumber
import pandas as pd
import os
from utils.config_util import Config


# ============================================================
# ------------------ SHARED UTILITIES ------------------------
# ============================================================

NUM_RE_GENERIC = re.compile(r'\(?-?\d[\d,]*\.?\d*\)?')


def clean_number(raw: str):
    txt = raw.strip()
    neg = txt.startswith('(') and txt.endswith(')')
    core = txt[1:-1] if neg else txt
    try:
        val = float(core.replace(',', ''))
        return -val if neg else val
    except ValueError:
        return None


def group_words_to_lines(words, y_tol=3.0):
    if not words:
        return []
    words_sorted = sorted(words, key=lambda w: (w['top'], w['x0']))
    lines, cur_line, cur_top = [], [], words_sorted[0]['top']

    for w in words_sorted:
        if abs(w['top'] - cur_top) <= y_tol:
            cur_line.append(w)
        else:
            lines.append(cur_line)
            cur_line = [w]
            cur_top = w['top']

    if cur_line:
        lines.append(cur_line)

    return lines


def extract_numeric_columns(line_words):
    values = []
    for w in line_words:
        m = NUM_RE_GENERIC.search(w['text'])
        if not m:
            continue
        val = clean_number(m.group(0))
        if val is None:
            continue
        center = (w['x0'] + w['x1']) / 2.0
        values.append((val, center))

    values.sort(key=lambda x: x[1])
    return [v[0] for v in values]


# ============================================================
# ------------------ LEDGER TYPE DETECTION -------------------
# ============================================================

def detect_ledger_type(pdf_path: str) -> str:
    filename = os.path.basename(pdf_path).upper()
    if "-APAC" in filename:
        return "APAC"
    elif "-US" in filename:
        return "US"
    return "UNKNOWN"


# ============================================================
# ------------------ US EXTRACTION (AUTO FORMAT) -------------
# ============================================================

# Pattern 1: Pure numeric (old format): 1234-123456
NUMERIC_LEASE_RE = re.compile(r'^(\d{4})[- ](\d{6})\b')

# Pattern 2: Alphanumeric starting with letter (old format): B00100-BFCL01, TCRCNY-TC1273
ALPHANUM_LETTER_START_RE = re.compile(r'^([A-Z][A-Z0-9]{4,})[- ]([A-Z0-9]{3,})\b')

# Pattern 3: Alphanumeric starting with digits (new format): 300B01-005376, 502B06-002722
ALPHANUM_DIGIT_START_RE = re.compile(r'^(\d{3,4}[A-Z]\d{2})[- ](\d{6})\b')

# Pattern 4: Property ID starting with P (new format): P90010-003147
PROPERTY_ID_RE = re.compile(r'^([A-Z]\d{5})[- ](\d{6})\b')


def detect_us_format(pdf_path):
    """Detect which format patterns exist in the PDF"""
    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages[:5]:
            lines = group_words_to_lines(page.extract_words())
            for line_words in lines:
                line_text = " ".join(w['text'] for w in line_words).strip()
                
                # Check all patterns
                if NUMERIC_LEASE_RE.match(line_text):
                    return "NUMERIC"
                if ALPHANUM_LETTER_START_RE.match(line_text):
                    return "ALPHANUM_LETTER"
                if ALPHANUM_DIGIT_START_RE.match(line_text):
                    return "ALPHANUM_DIGIT"
                if PROPERTY_ID_RE.match(line_text):
                    return "PROPERTY_ID"
    
    return "UNKNOWN"


def extract_totals_with_ids_US(pdf_path):
    lease_rows = []
    bldg_rows = []

    current_building = None
    current_lease = None

    format_type = detect_us_format(pdf_path)
    print(f"🔎 US Format Detected: {format_type}")

    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages:
            lines = group_words_to_lines(page.extract_words())

            for line_words in lines:
                line_text = " ".join(w['text'] for w in line_words).strip()
                lower = line_text.lower()

                # Skip metadata
                if any(x in lower for x in [
                    "category", "security deposit",
                    "occupancy status", "receipt type"
                ]):
                    continue

                # Skip column headers
                if any(x in lower for x in ["property lease", "building lease"]):
                    continue

                # Skip grand total explicitly
                if "grand" in lower and "total" in lower:
                    continue

                # ---------------- Lease Header ----------------
                # Try all patterns in order
                lease_match = None
                
                # Try Pattern 1: Pure numeric
                lease_match = NUMERIC_LEASE_RE.match(line_text)
                
                # Try Pattern 2: Letter start (B00100-BFCL01, TCRCNY-TC1273)
                if not lease_match:
                    lease_match = ALPHANUM_LETTER_START_RE.match(line_text)
                
                # Try Pattern 3: Digit start (300B01-005376, 502B06-002722)
                if not lease_match:
                    lease_match = ALPHANUM_DIGIT_START_RE.match(line_text)
                
                # Try Pattern 4: Property ID (P90010-003147)
                if not lease_match:
                    lease_match = PROPERTY_ID_RE.match(line_text)

                if lease_match:
                    current_building = lease_match.group(1).strip()
                    current_lease = lease_match.group(2).strip()
                    continue

                # ---------------- Totals Detection ----------------
                is_lease_total = lower.startswith("total:")

                is_bldg_total = (
                    ("totals for" in lower
                     or "building total" in lower
                     or "property total" in lower
                     or ("bldg" in lower and "total" in lower)
                     or ("property" in lower and "total" in lower))
                    and "grand" not in lower
                )

                if not (is_lease_total or is_bldg_total):
                    continue

                nums = extract_numeric_columns(line_words)
                if not nums:
                    continue

                charges = nums[2] if len(nums) >= 3 else None
                cash = nums[3] if len(nums) >= 4 else None

                if is_lease_total:
                    lease_rows.append({
                        "building": current_building,
                        "lease": current_lease,
                        "charges": charges,
                        "cash_receipts": cash
                    })

                elif is_bldg_total:
                    bldg_rows.append({
                        "building": current_building,
                        "charges": charges,
                        "cash_receipts": cash
                    })

    df_lease = pd.DataFrame(
        lease_rows,
        columns=["building", "lease", "charges", "cash_receipts"]
    )

    df_bldg = pd.DataFrame(
        bldg_rows,
        columns=["building", "charges", "cash_receipts"]
    )

    df_lease = df_lease.astype({"building": "string", "lease": "string"})
    df_bldg = df_bldg.astype({"building": "string"})

    print(f"📊 Extracted: {len(df_lease)} lease/property totals, {len(df_bldg)} building/property totals")

    return df_lease, df_bldg


# ============================================================
# ------------------ APAC EXTRACTION -------------------------
# ============================================================

LEASE_HEADER_RE_APAC = re.compile(r'(\d{3,6})[\s-]+(\d{5,6})')
IGNORE_PATTERNS = re.compile(
    r'(mo\.?\s*rep|beg\s*balance|end\s*balance|'
    r'sec\s*dep|prior\s*balance|opening\s*balance)',
    re.I
)


def extract_totals_with_ids_APAC(pdf_path):
    lease_rows = []
    current_building = None
    current_lease = None

    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages:
            lines = group_words_to_lines(page.extract_words())

            for line_words in lines:
                line_text = " ".join(w['text'] for w in line_words).strip()
                lower = line_text.lower()

                if not line_text or IGNORE_PATTERNS.search(line_text):
                    continue

                lease_match = LEASE_HEADER_RE_APAC.search(line_text)
                if lease_match:
                    current_building = lease_match.group(1).strip()
                    current_lease = lease_match.group(2).strip()

                if not lower.startswith("total:"):
                    continue

                nums = [clean_number(n) for n in re.findall(NUM_RE_GENERIC, line_text)]
                nums = [n for n in nums if n is not None]

                if not nums:
                    continue

                charges = nums[2] if len(nums) >= 3 else nums[0]
                cash = nums[3] if len(nums) >= 4 else 0.0

                lease_rows.append({
                    "building": current_building,
                    "lease": current_lease,
                    "charges": charges,
                    "cash_receipts": cash
                })

    df_lease = pd.DataFrame(
        lease_rows,
        columns=["building", "lease", "charges", "cash_receipts"]
    )

    df_lease = df_lease.astype({"building": "string", "lease": "string"})
    return df_lease, pd.DataFrame()


# ============================================================
# ------------------ EXCEL COMPARISON ------------------------
# ============================================================

def compare_excels(extracted_path, report_path, output_path):
    """
    Compare both LeaseTotals and BuildingTotals sheets from extracted
    and report Excel files, creating separate comparison sheets for each.
    """
    try:
        # Read extracted file sheets
        xl_extracted = pd.ExcelFile(extracted_path)

        # Read report file sheets
        xl_report = pd.ExcelFile(report_path)

        # Determine which sheets exist in both files
        extracted_sheets = xl_extracted.sheet_names
        report_sheets = xl_report.sheet_names

        print(f"📊 Extracted sheets: {extracted_sheets}")
        print(f"📊 Report sheets: {report_sheets}")

        # Create output Excel writer
        with pd.ExcelWriter(output_path, engine="openpyxl") as writer:

            # ========== Compare LeaseTotals ==========
            if "LeaseTotals" in extracted_sheets:
                df_extracted_lease = pd.read_excel(
                    extracted_path,
                    sheet_name="LeaseTotals",
                    dtype=str
                )

                # Try to find corresponding sheet in report
                report_lease_sheet = None
                for sheet in report_sheets:
                    if "lease" in sheet.lower() or sheet == "LeaseTotals":
                        report_lease_sheet = sheet
                        break

                if report_lease_sheet:
                    df_report_lease = pd.read_excel(
                        report_path,
                        sheet_name=report_lease_sheet,
                        dtype=str
                    )

                    # Perform lease-level comparison
                    merged_lease = _compare_dataframes(
                        df_extracted_lease,
                        df_report_lease,
                        merge_keys=["building", "lease"]
                    )

                    merged_lease.to_excel(
                        writer,
                        sheet_name="LeaseComparison",
                        index=False
                    )
                    print(f"✅ Lease comparison completed ({len(merged_lease)} records)")
                else:
                    print("⚠️ No lease sheet found in report Excel")

            # ========== Compare BuildingTotals ==========
            building_sheet_name = None
            for sheet in extracted_sheets:
                if "building" in sheet.lower() or "bldg" in sheet.lower():
                    building_sheet_name = sheet
                    break

            if building_sheet_name:
                df_extracted_bldg = pd.read_excel(
                    extracted_path,
                    sheet_name=building_sheet_name,
                    dtype=str
                )

                # Try to find corresponding sheet in report
                report_bldg_sheet = None
                for sheet in report_sheets:
                    if "building" in sheet.lower() or "bldg" in sheet.lower():
                        report_bldg_sheet = sheet
                        break

                if report_bldg_sheet:
                    df_report_bldg = pd.read_excel(
                        report_path,
                        sheet_name=report_bldg_sheet,
                        dtype=str
                    )

                    # Perform building-level comparison
                    merged_bldg = _compare_dataframes(
                        df_extracted_bldg,
                        df_report_bldg,
                        merge_keys=["building"]
                    )

                    merged_bldg.to_excel(
                        writer,
                        sheet_name="BuildingComparison",
                        index=False
                    )
                    print(f"✅ Building comparison completed ({len(merged_bldg)} records)")
                else:
                    print("⚠️ No building sheet found in report Excel")

        print(f"📁 All comparisons saved -> {output_path}")

    except Exception as e:
        print(f"❌ Comparison failed: {e}")
        import traceback
        traceback.print_exc()


def _compare_dataframes(df_extracted, df_report, merge_keys):
    """
    Helper function to compare two dataframes and add match columns.

    Args:
        df_extracted: DataFrame from PDF extraction
        df_report: DataFrame from report Excel
        merge_keys: List of columns to merge on (e.g., ["building", "lease"])

    Returns:
        DataFrame with comparison results
    """
    # Convert numeric columns
    for col in ["charges", "cash_receipts"]:
        for df in [df_extracted, df_report]:
            if col in df.columns:
                df[col] = pd.to_numeric(df[col], errors="coerce").fillna(0)

    # Normalize column names
    df_extracted.columns = df_extracted.columns.str.strip().str.lower()
    df_report.columns = df_report.columns.str.strip().str.lower()

    # Normalize merge keys
    merge_keys = [k.lower() for k in merge_keys]

    # Merge the dataframes
    merged = pd.merge(
        df_extracted,
        df_report,
        on=merge_keys,
        how="outer",
        suffixes=("_extracted", "_report")
    )

    # Add comparison columns
    merged["charges_match"] = (
        merged["charges_extracted"].round(2) ==
        merged["charges_report"].round(2)
    )

    merged["cash_match"] = (
        merged["cash_receipts_extracted"].round(2) ==
        merged["cash_receipts_report"].round(2)
    )

    merged["Overall_Match"] = (
        merged["charges_match"] & merged["cash_match"]
    )

    return merged



# ============================================================
# ------------------ MAIN ------------------------------------
# ============================================================

if __name__ == "__main__":

    start_time = time.time()
    config = Config()

    pdf_path = config.get("CM.LEDGER", "PDF")
    ledgers_totals_path = config.get("CM.LEDGER", "LedgerTotals")
    report_excel_path = config.get("CM.LEDGER", "ReportExcel")
    comparison_output_path = config.get("CM.LEDGER", "ComparisonResult")

    ledger_type = detect_ledger_type(pdf_path)
    print(f"📘 Ledger Type: {ledger_type}")

    if ledger_type == "US":
        df_lease, df_bldg = extract_totals_with_ids_US(pdf_path)
    elif ledger_type == "APAC":
        df_lease, df_bldg = extract_totals_with_ids_APAC(pdf_path)
    else:
        raise ValueError(f"Unknown ledger type for {pdf_path}")

    with pd.ExcelWriter(ledgers_totals_path, engine="openpyxl") as writer:
        df_lease.to_excel(writer, sheet_name="LeaseTotals", index=False)
        df_bldg.to_excel(writer, sheet_name="BuildingTotals", index=False)

    print(f"✅ Extraction saved -> {ledgers_totals_path}")

    if os.path.exists(report_excel_path):
        compare_excels(
            ledgers_totals_path,
            report_excel_path,
            comparison_output_path
        )

    print(f"⏱ Completed in {round(time.time() - start_time, 2)} seconds")