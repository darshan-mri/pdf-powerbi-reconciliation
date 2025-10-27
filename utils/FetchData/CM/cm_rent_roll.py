import re
import pandas as pd
from PyPDF2 import PdfReader
from utils.config_util import Config

# -------------CONFIGURATION-------------
cfg = Config()
pdf_path = cfg.get("CM.ROLL", "PDF")
output_excel = cfg.get("CM.ROLL", "ExtractedBuilding")

# ---------- READ PDF (preserve lines) ----------
reader = PdfReader(pdf_path)
pages_text = [page.extract_text() or "" for page in reader.pages]
full_text = "\n".join(pages_text)

# ---------- NORMALIZE COMMON MERGE ISSUES ----------
replacements = {
    "VacantSqft": "Vacant Sqft",
    "VacantSqFt": "Vacant Sqft",
    "TotalSqft": "Total Sqft",
    "Leased/UnoccupiedSqft": "Leased/Unoccupied Sqft",
    "AreaIncluded": "Area Included",
    "NotCounted": "Not Counted",
    "OccupiedSqft": "Occupied Sqft",
}
for old, new in replacements.items():
    full_text = full_text.replace(old, new)

full_text = re.sub(r"[ \t]+", " ", full_text)
lines = full_text.splitlines()

# ---------- helpers ----------
cum = []
total = 0
for ln in lines:
    cum.append(total)
    total += len(ln) + 1  # +1 for newline

def charpos_to_lineidx(charpos):
    lo, hi = 0, len(cum)-1
    while lo <= hi:
        mid = (lo + hi) // 2
        if cum[mid] <= charpos:
            lo = mid + 1
        else:
            hi = mid - 1
    return max(0, lo - 1)

def is_year_like(num_str):
    try:
        n = int(num_str)
        return 1900 <= n <= 2100
    except:
        return False

def parse_totals_block(block_text):
    occ_match = re.search(
        r'Occupied Sqft:\s*([\d,]+)\s*([\d.]+%)\s*([-\d,]+(?:\.\d+)?)\s*([-\d,]+(?:\.\d+)?)\s*([-\d,]+(?:\.\d+)?)',
        block_text
    )
    occ_sqft, occ_percent, occ_other_income, occ_cost_recovery, occ_base_rent = (
        occ_match.groups() if occ_match else ("0", "0%", "0", "0", "0")
    )

    occ_units = "0 Units"
    occ_units_match = re.search(
        r'{}\s*(\d+)Units(?=[^0-9]*Area Included Not Counted Sqft)'.format(re.escape(occ_base_rent)),
        block_text
    )
    if occ_units_match:
        occ_units_num = occ_units_match.group(1).lstrip("0") or "0"
        occ_units = f"{occ_units_num} Units"

    vac_section_match = re.search(r"Vacant Sqft:(.*)", block_text, re.DOTALL)
    vac_section = vac_section_match.group(1) if vac_section_match else ""
    vac_percent_match = re.search(r"([\d.]+%)", vac_section)
    vac_percent = vac_percent_match.group(1) if vac_percent_match else "0%"
    after_percent = vac_section.split(vac_percent)[-1] if vac_percent_match else vac_section
    vac_units_match = re.search(r"(\d+)Units", after_percent)
    vac_units = vac_units_match.group(1) + " Units" if vac_units_match else "0 Units"

    vac_sqft = "0"
    for num in re.findall(r"[\d,]+", after_percent):
        if int(num.replace(",", "")) >= 1000:
            vac_sqft = num
            break
    if vac_percent.strip() in ["0%", "0.00%"]:
        vac_sqft = "0"

    return {
        "Occupied Sqft": occ_sqft,
        "Occupied %": occ_percent,
        "Occupied Monthly Other Income": occ_other_income,
        "Occupied Monthly Cost Recovery": occ_cost_recovery,
        "Occupied Monthly Base Rent": occ_base_rent,
        "Occupied Units": occ_units,
        "Vacant Sqft": vac_sqft,
        "Vacant %": vac_percent,
        "Vacant Units": vac_units
    }

# ---------- STEP 1: Extract all building IDs robustly ----------
building_id_lines = []
for i, line in enumerate(lines):
    line = line.strip()
    if not line:
        continue

    # Alphanumeric IDs (JAL001, etc.)
    m = re.search(r"\b[A-Z]{2,4}\d{3}\b", line)
    if m:
        building_id_lines.append((i, m.group(0)))
        continue

    # Numeric IDs: ignore years
    nums = [int(n.replace(",", "")) for n in re.findall(r"\b\d{1,6}\b", line)]
    nums = [n for n in nums if not (1900 <= n <= 2100)]
    # Remove small numbers (likely sqft/rent values)
    candidates = [n for n in nums if n > 4000]
    if candidates:
        building_id_lines.append((i, str(candidates[0])))

# ---------- STEP 2: Totals blocks ----------
totals_iter = list(re.finditer(r"Totals:.*?(?=Database:|Totals:|$)", full_text, flags=re.S))

# ---------- STEP 3: Map Totals block to nearest preceding building ID ----------
parsed_rows = []
for m in totals_iter:
    start_idx = m.start()
    block_text = m.group(0)
    line_idx = charpos_to_lineidx(start_idx)

    candidate_ids = [bid for idx2, bid in building_id_lines if idx2 <= line_idx]
    building_id = candidate_ids[-1] if candidate_ids else "Unknown"

    parsed = parse_totals_block(block_text)
    parsed["Building ID"] = building_id
    parsed_rows.append(parsed)

# ---------- BUILD DATAFRAME ----------
df = pd.DataFrame(parsed_rows)
cols = [
    "Building ID",
    "Occupied Sqft", "Occupied %",
    "Occupied Monthly Other Income", "Occupied Monthly Cost Recovery", "Occupied Monthly Base Rent",
    "Occupied Units", "Vacant Sqft", "Vacant %", "Vacant Units"
]
for c in cols:
    if c not in df.columns:
        df[c] = ""
df = df[cols]

# ---------- SAVE OUTPUT ----------
df.to_excel(output_excel, index=False)
print(f"Saved {len(df)} rows → {output_excel}")
print(df)
