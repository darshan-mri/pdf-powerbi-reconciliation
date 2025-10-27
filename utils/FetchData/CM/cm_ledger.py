# # extract_totals_with_building_lease.py
#
# import re
# import time
# import pdfplumber
# import pandas as pd
# from utils.config_util import Config
#
# NUM_RE = re.compile(r'\(?-?\d[\d,]*\.?\d*\)?')
# LEASE_HEADER_RE = re.compile(r'(\d{4})[- ](\d{6})')
#
# def group_words_to_lines(words, y_tol=3.0):
#     if not words:
#         return []
#     words_sorted = sorted(words, key=lambda w: (w['top'], w['x0']))
#     lines = []
#     cur_line = []
#     cur_top = words_sorted[0]['top']
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
#         m = NUM_RE.search(w['text'])
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
# def _pick_charges_cash(nums_vals):
#     # Fixed mapping: 3rd value -> charges, 4th value -> cash receipts
#     charges = nums_vals[2] if len(nums_vals) >= 3 else None
#     cash = nums_vals[3] if len(nums_vals) >= 4 else None
#     return charges, cash
#
# def _is_building_total(lower_line: str) -> bool:
#     if "grand" in lower_line:
#         return False
#     if "totals for" in lower_line:
#         return True
#     # Any combination containing bldg + total
#     if "bldg" in lower_line and "total" in lower_line:
#         return True
#     if "building total" in lower_line:
#         return True
#     return False
#
# def extract_totals_with_ids(pdf_path):
#     lease_rows = []
#     bldg_rows = []
#     current_building = None
#     current_lease = None
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
#                 # Capture building + lease ids
#                 lease_match = LEASE_HEADER_RE.search(line_text)
#                 if lease_match:
#                     current_building = lease_match.group(1)
#                     current_lease = lease_match.group(2)
#
#                 is_lease_total = lower.startswith("total:")
#                 is_bldg_total = _is_building_total(lower)
#
#                 if not (is_lease_total or is_bldg_total):
#                     continue
#
#                 nums = numeric_center_map(line_words)
#                 if not nums:
#                     continue
#                 nums_vals = [t[0] for t in nums]
#
#                 charges_val, cash_val = _pick_charges_cash(nums_vals)
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
#     return pd.DataFrame(lease_rows), pd.DataFrame(bldg_rows)
#
# if __name__ == "__main__":
#     start_time = time.time()
#     config = Config()
#     pdf_path = config.get("CM.LEDGER", "PDF")
#     ledgers_totals_path = config.get("CM.LEDGER", "LedgerTotals")
#
#     df_lease, df_bldg = extract_totals_with_ids(pdf_path)
#
#     if df_lease.empty:
#         df_lease = pd.DataFrame(columns=["building", "lease", "charges", "cash_receipts"])
#     if df_bldg.empty:
#         df_bldg = pd.DataFrame(columns=["building", "charges", "cash_receipts"])
#
#     with pd.ExcelWriter(ledgers_totals_path, engine="openpyxl") as writer:
#         df_lease.to_excel(writer, sheet_name="LeaseTotals", index=False)
#         df_bldg.to_excel(writer, sheet_name="BldgTotals", index=False)
#
#         if not df_lease.empty and not df_bldg.empty:
#             lease_summary = df_lease.groupby("building", as_index=False).agg(
#                 lease_charges_sum=("charges", "sum"),
#                 lease_cash_sum=("cash_receipts", "sum")
#             )
#             bldg_summary = df_bldg.groupby("building", as_index=False).agg(
#                 bldg_charges=("charges", "sum"),
#                 bldg_cash=("cash_receipts", "sum")
#             )
#             comparison = pd.merge(lease_summary, bldg_summary, on="building", how="outer")
#             comparison["Match?"] = (
#                 comparison["lease_charges_sum"].round(2) == comparison["bldg_charges"].round(2)
#             ) & (
#                 comparison["lease_cash_sum"].round(2) == comparison["bldg_cash"].round(2)
#             )
#             comparison.to_excel(writer, sheet_name="Comparison", index=False)
#
#     print(f"Saved -> {ledgers_totals_path}")
#     print(f"Execution time: {round(time.time() - start_time, 2)}s")
#

# extract_totals_with_building_lease.py -- Final version with comparison --

# import re
# import time
# import pdfplumber
# import pandas as pd
# from utils.config_util import Config
#
# NUM_RE = re.compile(r'\(?-?\d[\d,]*\.?\d*\)?')
# LEASE_HEADER_RE = re.compile(r'(\d{4})[- ](\d{6})')
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
#         m = NUM_RE.search(w['text'])
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
# def _pick_charges_cash(nums_vals):
#     # Fixed mapping: 3rd value -> charges, 4th value -> cash receipts
#     charges = nums_vals[2] if len(nums_vals) >= 3 else None
#     cash = nums_vals[3] if len(nums_vals) >= 4 else None
#     return charges, cash
#
# def _is_building_total(lower_line: str) -> bool:
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
# def extract_totals_with_ids(pdf_path):
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
#                 lease_match = LEASE_HEADER_RE.search(line_text)
#                 if lease_match:
#                     # Preserve leading zeros by keeping as strings
#                     current_building = lease_match.group(1).zfill(4)
#                     current_lease = lease_match.group(2).zfill(6)
#
#                 is_lease_total = lower.startswith("total:")
#                 is_bldg_total = _is_building_total(lower)
#
#                 if not (is_lease_total or is_bldg_total):
#                     continue
#
#                 nums = numeric_center_map(line_words)
#                 if not nums:
#                     continue
#                 nums_vals = [t[0] for t in nums]
#
#                 charges_val, cash_val = _pick_charges_cash(nums_vals)
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
#     # Ensure IDs remain as strings
#     df_lease = pd.DataFrame(lease_rows, columns=["building", "lease", "charges", "cash_receipts"])
#     df_bldg = pd.DataFrame(bldg_rows, columns=["building", "charges", "cash_receipts"])
#     df_lease = df_lease.astype({"building": "string", "lease": "string"})
#     df_bldg = df_bldg.astype({"building": "string"})
#     return df_lease, df_bldg
#
#
# def compare_excels(extracted_path, report_path, output_path):
#     """Compare extracted excel (LeaseTotals sheet) with report excel, preserving IDs"""
#     try:
#         # Read both as strings to preserve leading zeros
#         df_extracted = pd.read_excel(extracted_path, sheet_name="LeaseTotals", dtype=str)
#         df_report = pd.read_excel(report_path, dtype=str)
#
#         # Convert numeric columns safely
#         for col in ["charges", "cash_receipts"]:
#             for df in [df_extracted, df_report]:
#                 if col in df.columns:
#                     df[col] = pd.to_numeric(df[col], errors="coerce").fillna(0)
#
#         # Normalize column names
#         df_extracted.columns = df_extracted.columns.str.strip().str.lower()
#         df_report.columns = df_report.columns.str.strip().str.lower()
#
#         # Merge on building + lease (as strings)
#         merged = pd.merge(
#             df_extracted,
#             df_report,
#             on=["building", "lease"],
#             how="outer",
#             suffixes=("_extracted", "_report")
#         )
#
#         # Compare numeric columns
#         merged["charges_match"] = (
#             merged["charges_extracted"].round(2) == merged["charges_report"].round(2)
#         )
#         merged["cash_match"] = (
#             merged["cash_receipts_extracted"].round(2) == merged["cash_receipts_report"].round(2)
#         )
#         merged["Overall_Match"] = merged["charges_match"] & merged["cash_match"]
#
#         # Ensure IDs retain formatting
#         merged["building"] = merged["building"].astype(str).str.zfill(4)
#         merged["lease"] = merged["lease"].astype(str).str.zfill(6)
#
#         # Save comparison (retain as text in Excel)
#         with pd.ExcelWriter(output_path, engine="openpyxl") as writer:
#             merged.to_excel(writer, index=False)
#         print(f"Comparison saved -> {output_path}")
#
#     except Exception as e:
#         print(f"Comparison failed: {e}")
#
#
# if __name__ == "__main__":
#     start_time = time.time()
#     config = Config()
#     pdf_path = config.get("CM.LEDGER", "PDF")
#     ledgers_totals_path = config.get("CM.LEDGER", "LedgerTotals")
#     report_excel_path = config.get("CM.LEDGER", "ReportExcel")
#     comparison_output_path = config.get("CM.LEDGER", "ComparisonResult")
#
#     df_lease, df_bldg = extract_totals_with_ids(pdf_path)
#
#     if df_lease.empty:
#         df_lease = pd.DataFrame(columns=["building", "lease", "charges", "cash_receipts"])
#     if df_bldg.empty:
#         df_bldg = pd.DataFrame(columns=["building", "charges", "cash_receipts"])
#
#     with pd.ExcelWriter(ledgers_totals_path, engine="openpyxl") as writer:
#         df_lease.to_excel(writer, sheet_name="LeaseTotals", index=False)
#         df_bldg.to_excel(writer, sheet_name="BldgTotals", index=False)
#
#         if not df_lease.empty and not df_bldg.empty:
#             lease_summary = df_lease.groupby("building", as_index=False).agg(
#                 lease_charges_sum=("charges", "sum"),
#                 lease_cash_sum=("cash_receipts", "sum")
#             )
#             bldg_summary = df_bldg.groupby("building", as_index=False).agg(
#                 bldg_charges=("charges", "sum"),
#                 bldg_cash=("cash_receipts", "sum")
#             )
#             comparison = pd.merge(lease_summary, bldg_summary, on="building", how="outer")
#             comparison["Match?"] = (
#                 comparison["lease_charges_sum"].round(2) == comparison["bldg_charges"].round(2)
#             ) & (
#                 comparison["lease_cash_sum"].round(2) == comparison["bldg_cash"].round(2)
#             )
#             comparison.to_excel(writer, sheet_name="Comparison", index=False)
#
#     print(f"Extracted totals saved -> {ledgers_totals_path}")
#
#     # Run Excel comparison after extraction
#     compare_excels(ledgers_totals_path, report_excel_path, comparison_output_path)
#
#     print(f"⚙Execution time: {round(time.time() - start_time, 2)}s")


#Trying out this new version below
# import re
# import time
# import pandas as pd
# import pdfplumber
# from utils.config_util import Config
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
# # ------------------ COLUMN POSITION DETECTION ------------------
#
# def find_column_positions(page_words):
#     """
#     Detect header column x-positions for Charges and Cash Receipts.
#     Works with variations like 'Cash Rcpts', 'Cash Receipt', etc.
#     """
#     positions = {}
#     for w in page_words:
#         text = w['text'].strip().lower()
#         x_center = (w['x0'] + w['x1']) / 2
#         # Charges column
#         if 'charges' in text and 'sec' not in text:
#             positions['charges_x'] = x_center
#         # Cash Receipts column (flexible matching)
#         elif 'cash' in text and ('receipt' in text or 'rcpt' in text):
#             positions['cash_x'] = x_center
#     return positions
#
# # ------------------ BUILDING TOTAL DETECTION ------------------
#
# def _is_building_total(lower_line: str, prev_line: str | None = None) -> bool:
#     """Detect lines referring to a building total (fuzzy matching)."""
#     if not lower_line.strip() or "grand" in lower_line:
#         return False
#     # Flexible total patterns
#     if re.search(r'\btotals?\b.*\(bldg[:\s]*\d{3,}\)', lower_line):
#         return True
#     if re.search(r'totals?\s+for\s+.*bldg[:\s]*\d{3,}', lower_line):
#         return True
#     if re.search(r'\bbldg[:\s]*\d{3,}.*totals?\b', lower_line):
#         return True
#     if re.search(r'\btotals?\b.*building', lower_line):
#         return True
#     if re.search(r'\btotals?\b.*street', lower_line):
#         return True
#     # If previous line contained BLDG and current line has total
#     if prev_line:
#         pl = prev_line.lower()
#         if ('bldg' in pl or '(bldg:' in pl) and "total" in lower_line:
#             return True
#     return False
#
# # ------------------ LINE GROUPING ------------------
#
# NUM_RE = re.compile(r'\(?-?\d[\d,]*\.?\d*\)?')
# LEASE_HEADER_RE = re.compile(r'(\d{3,6})[\s-]+(\d{5,6})')
# BLDG_RE = re.compile(r'\(bldg[:\s]*([0-9]+)\)', re.I)
# IGNORE_PATTERNS = re.compile(
#     r'(mo\.?\s*rep|beg\s*balance|end\s*balance|sec\s*dep|prior\s*balance|opening\s*balance)',
#     re.I
# )
#
# def group_words_to_lines(words, y_tol=3.0):
#     if not words:
#         return []
#     words_sorted = sorted(words, key=lambda w: (w['top'], w['x0']))
#     lines, cur_line = [], []
#     cur_top = words_sorted[0]['top']
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
# # ------------------ PARSING ------------------
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
#     text_line = " ".join(w["text"] for w in line_words).strip()
#     if IGNORE_PATTERNS.search(text_line):
#         return []
#     entries = []
#     for w in line_words:
#         m = NUM_RE.search(w["text"])
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
# def _find_nearest_value(nums, target_x, tolerance=40):
#     """Return the numeric value whose center x is nearest to target_x."""
#     if not nums or target_x is None:
#         return None
#     nums_sorted = sorted(nums, key=lambda t: abs(t[1] - target_x))
#     if abs(nums_sorted[0][1] - target_x) <= tolerance:
#         return nums_sorted[0][0]
#     return None
#
# def _pick_charges_cash_from_positions(nums, positions=None, tolerance=40):
#     """
#     Pick Charges and Cash Receipts by matching numeric x-centers
#     to detected header column x-centers. Avoid fallback to unrelated numbers.
#     """
#     charges_val = 0.0
#     cash_val = 0.0
#
#     if not nums:
#         return charges_val, cash_val
#
#     if positions:
#         # Find nearest numeric to Charges column
#         charges_val = _find_nearest_value(nums, positions.get("charges_x"), tolerance)
#         # Find nearest numeric to Cash Receipts column
#         cash_val = _find_nearest_value(nums, positions.get("cash_x"), tolerance)
#
#     # Safety: if a column header was detected but no number is near it, keep 0
#     charges_val = charges_val if charges_val is not None else 0.0
#     cash_val = cash_val if cash_val is not None else 0.0
#
#     return charges_val, cash_val
#
# # ------------------ MAIN EXTRACTION ------------------
#
# def extract_totals_with_ids(pdf_path):
#     lease_rows, bldg_rows = [], []
#     current_building, current_lease = None, None
#     last_line_text = ""
#     last_bldg_seen = None  # cross-page carry
#
#     with pdfplumber.open(pdf_path) as pdf:
#         for page in pdf.pages:
#             words = page.extract_words()
#             positions = find_column_positions(words)
#             print(f"\nDetected columns (page {page.page_number}): {positions}")
#             lines = group_words_to_lines(words, y_tol=3.0)
#
#             for line_words in lines:
#                 line_text = " ".join(w['text'] for w in line_words).strip()
#                 if IGNORE_PATTERNS.search(line_text):
#                     continue
#                 lower = line_text.lower()
#
#                 lease_match = LEASE_HEADER_RE.search(line_text)
#                 if lease_match:
#                     current_building = lease_match.group(1).zfill(4)
#                     current_lease = lease_match.group(2).zfill(6)
#                     last_bldg_seen = current_building
#
#                 bldg_match = BLDG_RE.search(line_text)
#                 if bldg_match:
#                     current_building = bldg_match.group(1).zfill(6)
#                     last_bldg_seen = current_building
#
#                 is_lease_total = lower.strip().startswith("total:")
#                 is_bldg_total = _is_building_total(lower, last_line_text.lower() if last_line_text else None)
#                 if not (is_lease_total or is_bldg_total):
#                     last_line_text = line_text
#                     continue
#
#                 nums = numeric_center_map(line_words)
#                 if not nums:
#                     last_line_text = line_text
#                     continue
#
#                 charges_val, cash_val = _pick_charges_cash_from_positions(nums, positions)
#
#                 # DEBUG: print numeric mapping
#                 print(f"Line: {line_text}")
#                 print(f"Nums detected: {nums}")
#                 print(f"Picked Charges: {charges_val}, Cash Receipts: {cash_val}")
#
#                 if is_lease_total:
#                     lease_rows.append({
#                         "building": current_building or last_bldg_seen,
#                         "lease": current_lease,
#                         "charges": charges_val,
#                         "cash_receipts": cash_val
#                     })
#                 elif is_bldg_total:
#                     bldg_rows.append({
#                         "building": current_building or last_bldg_seen,
#                         "charges": charges_val,
#                         "cash_receipts": cash_val
#                     })
#                     print(f"📘 Found building total line -> {line_text}")
#
#                 last_line_text = line_text
#
#     df_lease = pd.DataFrame(lease_rows, columns=["building", "lease", "charges", "cash_receipts"])
#     df_bldg = pd.DataFrame(bldg_rows, columns=["building", "charges", "cash_receipts"])
#     df_lease = df_lease.astype({"building": "string", "lease": "string"})
#     df_bldg = df_bldg.astype({"building": "string"})
#     return df_lease, df_bldg
#
# # ------------------ MAIN ------------------
#
# if __name__ == "__main__":
#     start_time = time.time()
#     config = Config()
#     pdf_path = config.get("CM.LEDGER", "PDF")
#
#     print(">>> Running enhanced extraction preview...")
#     df_lease, df_bldg = extract_totals_with_ids(pdf_path)
#
#     print("\n--- LeaseTotals sample ---")
#     print(df_lease.head(10).to_string(index=False))
#
#     print("\n--- BldgTotals sample ---")
#     print(df_bldg.head(10).to_string(index=False))
#
#     print(f"\nExecution time: {round(time.time() - start_time, 2)} s")

#this is the part of the above script that saves the extracted data and runs the comparison
# if __name__ == "__main__":
#     start_time = time.time()
#     config = Config()
#
#     pdf_path = config.get("CM.LEDGER", "PDF")
#     ledgers_totals_path = config.get("CM.LEDGER", "LedgerTotals")
#     report_excel_path = config.get("CM.LEDGER", "ReportExcel")
#     comparison_output_path = config.get("CM.LEDGER", "ComparisonResult")
#
#     df_lease, df_bldg = extract_totals_with_ids(pdf_path)
#
#     if df_lease.empty:
#         df_lease = pd.DataFrame(columns=["building", "lease", "charges", "cash_receipts"])
#     if df_bldg.empty:
#         df_bldg = pd.DataFrame(columns=["building", "charges", "cash_receipts"])
#
#     with pd.ExcelWriter(ledgers_totals_path, engine="openpyxl") as writer:
#         df_lease.to_excel(writer, sheet_name="LeaseTotals", index=False)
#         df_bldg.to_excel(writer, sheet_name="BldgTotals", index=False)
#
#         if not df_lease.empty and not df_bldg.empty:
#             lease_summary = df_lease.groupby("building", as_index=False).agg(
#                 lease_charges_sum=("charges", "sum"),
#                 lease_cash_sum=("cash_receipts", "sum")
#             )
#             bldg_summary = df_bldg.groupby("building", as_index=False).agg(
#                 bldg_charges=("charges", "sum"),
#                 bldg_cash=("cash_receipts", "sum")
#             )
#
#             comparison = pd.merge(lease_summary, bldg_summary, on="building", how="outer")
#             comparison["Match?"] = (
#                 (comparison["lease_charges_sum"].round(2) == comparison["bldg_charges"].round(2))
#                 & (comparison["lease_cash_sum"].round(2) == comparison["bldg_cash"].round(2))
#             )
#             comparison.to_excel(writer, sheet_name="Comparison", index=False)
#
#     print(f"Extracted totals saved -> {ledgers_totals_path}")
#     compare_excels(ledgers_totals_path, report_excel_path, comparison_output_path)
#     print(f"⚙ Execution time: {round(time.time() - start_time, 2)}s")


import re
import time
import pdfplumber
import pandas as pd
from utils.config_util import Config
import os

# ------------------ NUMERIC CLEANING ------------------

def _clean_num_token(tok: str):
    t = tok.replace(',', '').strip()
    if t.startswith('(') and t.endswith(')'):
        t = '-' + t[1:-1]
    try:
        return float(t)
    except Exception:
        return None

# ------------------ LEDGER TYPE DETECTION ------------------

def detect_ledger_type(pdf_path: str) -> str:
    filename = os.path.basename(pdf_path).upper()
    if "-AUS" in filename or "-AUNZ" in filename:
        return "AUNZ"
    elif "-US" in filename:
        return "US"
    else:
        return "UNKNOWN"

# ===================== US Extraction Logic =====================

NUM_RE_US = re.compile(r'\(?-?\d[\d,]*\.?\d*\)?')
LEASE_HEADER_RE_US = re.compile(r'(\d{4})[- ](\d{6})')

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

def _parse_number_token(raw: str):
    txt = raw.strip()
    neg = txt.startswith('(') and txt.endswith(')')
    core = txt[1:-1] if neg else txt
    try:
        val = float(core.replace(',', ''))
        return -val if neg else val
    except ValueError:
        return None

def numeric_center_map(line_words):
    entries = []
    for w in line_words:
        m = NUM_RE_US.search(w['text'])
        if not m:
            continue
        raw = m.group(0)
        val = _parse_number_token(raw)
        if val is None:
            continue
        center = (w['x0'] + w['x1']) / 2.0
        entries.append((val, center, w['text']))
    entries.sort(key=lambda e: e[1])
    return entries

def _pick_charges_cash_US(nums_vals):
    charges = nums_vals[2] if len(nums_vals) >= 3 else None
    cash = nums_vals[3] if len(nums_vals) >= 4 else None
    return charges, cash

def _is_building_total_US(lower_line: str) -> bool:
    if "grand" in lower_line:
        return False
    if "totals for" in lower_line:
        return True
    if "bldg" in lower_line and "total" in lower_line:
        return True
    if "building total" in lower_line:
        return True
    return False

def extract_totals_with_ids_US(pdf_path):
    lease_rows, bldg_rows = [], []
    current_building, current_lease = None, None

    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages:
            words = page.extract_words()
            lines = group_words_to_lines(words, y_tol=3.0)

            for line_words in lines:
                line_text = " ".join(w['text'] for w in line_words).strip()
                lower = line_text.lower()

                lease_match = LEASE_HEADER_RE_US.search(line_text)
                if lease_match:
                    current_building = lease_match.group(1).zfill(4)
                    current_lease = lease_match.group(2).zfill(6)

                is_lease_total = lower.startswith("total:")
                is_bldg_total = _is_building_total_US(lower)

                if not (is_lease_total or is_bldg_total):
                    continue

                nums = numeric_center_map(line_words)
                if not nums:
                    continue
                nums_vals = [t[0] for t in nums]

                charges_val, cash_val = _pick_charges_cash_US(nums_vals)

                if is_lease_total:
                    lease_rows.append({
                        "building": current_building,
                        "lease": current_lease,
                        "charges": charges_val,
                        "cash_receipts": cash_val
                    })
                elif is_bldg_total:
                    bldg_rows.append({
                        "building": current_building,
                        "charges": charges_val,
                        "cash_receipts": cash_val
                    })

    df_lease = pd.DataFrame(lease_rows, columns=["building", "lease", "charges", "cash_receipts"])
    df_bldg = pd.DataFrame(bldg_rows, columns=["building", "charges", "cash_receipts"])
    df_lease = df_lease.astype({"building": "string", "lease": "string"})
    df_bldg = df_bldg.astype({"building": "string"})
    return df_lease, df_bldg

# ===================== AUS Extraction Logic =====================

NUM_RE_AUS = re.compile(r'-?\(?\d[\d,]*\.?\d*\)?')
LEASE_HEADER_RE_AUS = re.compile(r'(\d{3,6})[\s-]+(\d{5,6})')
BLDG_RE_AUS = re.compile(r'\(bldg[:\s]*([0-9]+)\)', re.I)
IGNORE_PATTERNS = re.compile(
    r'(mo\.?\s*rep|beg\s*balance|end\s*balance|sec\s*dep|prior\s*balance|opening\s*balance)',
    re.I
)

def parse_total_line_AUS(line: str, is_bldg_total: bool = False):
    nums = [_clean_num_token(x) for x in re.findall(NUM_RE_AUS, line)]
    nums = [n for n in nums if n is not None]
    if not nums:
        return 0.0, 0.0

    charges, cash = 0.0, 0.0

    if len(nums) >= 4:
        charges = nums[2]
        cash = nums[3]
    else:
        charges_idx = max(range(len(nums)), key=lambda i: abs(nums[i]))
        charges = nums[charges_idx]
        cash = nums[charges_idx + 1] if charges_idx + 1 < len(nums) else 0.0

    return charges, cash

def _is_building_total_AUS(lower_line: str, prev_line: str | None = None) -> bool:
    if not lower_line.strip() or "grand" in lower_line:
        return False

    patterns = [
        r'\b(bldg|building)\b.*total',
        r'totals?\s+for\s+(bldg|building)',
        r'\bproperty\b.*total',
        r'\bbuilding\s*\d+\b',
    ]
    for pat in patterns:
        if re.search(pat, lower_line, re.I):
            return True

    if prev_line and ('bldg' in prev_line.lower() or 'building' in prev_line.lower()) and "total" in lower_line:
        return True

    return False

def extract_totals_with_ids_AUS(pdf_path):
    lease_rows, bldg_rows = [], []
    current_building, current_lease = None, None
    last_line_text = ""
    last_bldg_seen = None

    with pdfplumber.open(pdf_path) as pdf:
        for page_num, page in enumerate(pdf.pages, start=1):
            words = page.extract_words()
            lines = group_words_to_lines(words, y_tol=3.0)

            for line_words in lines:
                line_text = " ".join(w['text'] for w in line_words).strip()
                if not line_text or IGNORE_PATTERNS.search(line_text):
                    continue

                lower = line_text.lower()
                lease_match = LEASE_HEADER_RE_AUS.search(line_text)
                if lease_match:
                    current_building = lease_match.group(1).zfill(4)
                    current_lease = lease_match.group(2).zfill(6)
                    last_bldg_seen = current_building

                bldg_match = BLDG_RE_AUS.search(line_text)
                if bldg_match:
                    current_building = bldg_match.group(1).zfill(6)
                    last_bldg_seen = current_building

                is_lease_total = lower.startswith("total:")
                is_bldg_total = _is_building_total_AUS(lower, last_line_text)

                if is_lease_total or is_bldg_total:
                    charges, cash = parse_total_line_AUS(
                        line_text,
                        is_bldg_total=is_bldg_total
                    )

                    if is_lease_total:
                        lease_rows.append({
                            "building": current_building or last_bldg_seen,
                            "lease": current_lease,
                            "charges": charges,
                            "cash_receipts": cash
                        })
                    elif is_bldg_total:
                        bldg_rows.append({
                            "building": current_building or last_bldg_seen,
                            "charges": charges,
                            "cash_receipts": cash
                        })

                last_line_text = line_text

    df_lease = pd.DataFrame(lease_rows, columns=["building", "lease", "charges", "cash_receipts"])
    df_bldg = pd.DataFrame(bldg_rows, columns=["building", "charges", "cash_receipts"])
    df_lease = df_lease.astype({"building": "string", "lease": "string"})
    df_bldg = df_bldg.astype({"building": "string"})
    return df_lease, df_bldg

# ===================== EXCEL COMPARISON =====================

def compare_excels(extracted_path, report_path, output_path):
    try:
        df_extracted = pd.read_excel(extracted_path, sheet_name="LeaseTotals", dtype=str)
        df_report = pd.read_excel(report_path, dtype=str)

        for col in ["charges", "cash_receipts"]:
            for df in [df_extracted, df_report]:
                if col in df.columns:
                    df[col] = pd.to_numeric(df[col], errors="coerce").fillna(0)

        df_extracted.columns = df_extracted.columns.str.strip().str.lower()
        df_report.columns = df_report.columns.str.strip().str.lower()

        merged = pd.merge(
            df_extracted,
            df_report,
            on=["building", "lease"],
            how="outer",
            suffixes=("_extracted", "_report")
        )

        merged["charges_match"] = (
            merged["charges_extracted"].round(2) == merged["charges_report"].round(2)
        )
        merged["cash_match"] = (
            merged["cash_receipts_extracted"].round(2) == merged["cash_receipts_report"].round(2)
        )
        merged["Overall_Match"] = merged["charges_match"] & merged["cash_match"]

        merged["building"] = merged["building"].astype(str).str.zfill(4)
        merged["lease"] = merged["lease"].astype(str).str.zfill(6)

        with pd.ExcelWriter(output_path, engine="openpyxl") as writer:
            merged.to_excel(writer, index=False)
        print(f"Comparison saved -> {output_path}")

    except Exception as e:
        print(f"Comparison failed: {e}")

# ===================== MAIN =====================

if __name__ == "__main__":
    start_time = time.time()
    config = Config()
    pdf_path = config.get("CM.LEDGER", "PDF")
    ledgers_totals_path = config.get("CM.LEDGER", "LedgerTotals")
    report_excel_path = config.get("CM.LEDGER", "ReportExcel")
    comparison_output_path = config.get("CM.LEDGER", "ComparisonResult")

    ledger_type = detect_ledger_type(pdf_path)
    print(f"📘 Detected Ledger Type: {ledger_type}")

    if ledger_type == "US":
        df_lease, df_bldg = extract_totals_with_ids_US(pdf_path)
    elif ledger_type == "AUNZ":
        df_lease, df_bldg = extract_totals_with_ids_AUS(pdf_path)
    else:
        raise ValueError(f"Unknown ledger type for {pdf_path}")

    # Save extraction
    if df_lease.empty:
        df_lease = pd.DataFrame(columns=["building", "lease", "charges", "cash_receipts"])
    if df_bldg.empty:
        df_bldg = pd.DataFrame(columns=["building", "charges", "cash_receipts"])

    with pd.ExcelWriter(ledgers_totals_path, engine="openpyxl") as writer:
        df_lease.to_excel(writer, sheet_name="LeaseTotals", index=False, float_format="%.2f")
        df_bldg.to_excel(writer, sheet_name="BldgTotals", index=False, float_format="%.2f")

    print(f"\n✅ Extracted totals saved -> {ledgers_totals_path}")

    # Compare against report Excel
    compare_excels(ledgers_totals_path, report_excel_path, comparison_output_path)

    print(f"⚙ Execution time: {round(time.time() - start_time, 2)}s")
