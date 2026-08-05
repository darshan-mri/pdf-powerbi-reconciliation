"""
RAW TOTAL EXTRACTION SCRIP

- Extracts ALL Total lines
- Handles Path correctly
- No errors
"""

import re
import pandas as pd
import fitz
import sys
from pathlib import Path

_PROJECT_ROOT = Path(__file__).resolve().parents[3]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))
from utils.config_util import Config

cfg = Config()

pdf_path = cfg.get("CM.AGED", "PDF")

# ✅ CORRECT PATH HANDLING
output_path = Path(cfg.get("CM.AGED", "OccupantTotals"))
output_file = output_path.with_name(output_path.stem + "_RAW_TOTALS.xlsx")

print("="*80)
print("RAW TOTAL EXTRACTION")
print("="*80)

# ----------------------------------------------------------------------------
# REGEX
# ----------------------------------------------------------------------------
NUMBER_RE = re.compile(r'[\-(]?[\d,]+\.[\d]+\)?')

def clean_number(s):
    if s.startswith("("):
        return -float(s[1:-1].replace(",", ""))
    return float(s.replace(",", ""))

# ----------------------------------------------------------------------------
# READ PDF
# ----------------------------------------------------------------------------
doc = fitz.open(pdf_path)

lines = []
for page in doc:
    lines.extend(page.get_text("text").split("\n"))

doc.close()

print(f"Total lines extracted: {len(lines)}")

# ----------------------------------------------------------------------------
# EXTRACT TOTALS
# ----------------------------------------------------------------------------
records = []

for i, line in enumerate(lines):

    line = line.strip()
    if not line:
        continue

    if "Total" in line:

        nums = NUMBER_RE.findall(line)

        # Deep scan
        for j in range(i + 1, min(i + 120, len(lines))):

            next_line = lines[j].strip()

            if not next_line or next_line == ":":
                continue

            found = NUMBER_RE.findall(next_line)

            if found:
                nums.extend(found)

            if len(nums) >= 6:
                break

        values = [clean_number(n) for n in nums[:6]] if nums else []

        records.append({
            "LineNo": i,
            "RawLine": line,
            "ValueCount": len(nums),
            "Amount": values[0] if len(values) > 0 else None,
            "Current": values[1] if len(values) > 1 else None,
            "Month_1": values[2] if len(values) > 2 else None,
            "Month_2": values[3] if len(values) > 3 else None,
            "Month_3": values[4] if len(values) > 4 else None,
            "Month_4": values[5] if len(values) > 5 else None,
        })

df_raw = pd.DataFrame(records)

print(f"\nTotal raw 'Total' lines extracted: {len(df_raw)}")

# ----------------------------------------------------------------------------
# SAVE
# ----------------------------------------------------------------------------
df_raw.to_excel(output_file, index=False)

print(f"\n✅ Saved to:\n{output_file}")
print("="*80)