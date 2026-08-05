import re
import sys
from pathlib import Path

import pandas as pd
import pdfplumber

# Allow running this file directly (python utils/BPG/PropertyStatusReport.py).
_PROJECT_ROOT = Path(__file__).resolve().parents[2]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))

from utils.config_util import Config

# ===========================================
# CONFIG
# ===========================================

cfg = Config()

pdf_path = cfg.get(
    section="BPG",
    key="PropStatusPDF"
)

output_excel = cfg.get(
    section="BPG",
    key="PropStatusExcel"
)

# ===========================================
# PATTERNS
# ===========================================

HEADER_PATTERN = re.compile(r"^(.*?)\s+\(([A-Za-z0-9]+)\)$")

TOTAL_PATTERN = re.compile(
    r"^Totals\s+"
    r"([\d,.]+)\s+"
    r"([\d,.]+)\s+"
    r"([\d,.]+)\s+"
    r"(-?\d+)\s+"
    r"(-?\d+)\s+"
    r"(-?\d+)\s+"
    r"(-?\d+)\s+"
    r"([\d.]+%)\s+"
    r"(-?\d+)\s+"
    r"(-?\d+)\s+"
    r"(-?\d+)\s+"
    r"(-?\d+)$"
)

OCCUPANCY_START_MARKER = "Occupancy Information"
OCCUPANCY_END_MARKERS = (
    "Projected Occupancy",
    "Current Occupancy Information",
)


def parse_float(value: str) -> float:
    return float(value.replace(",", "").replace("%", ""))


def parse_int(value: str) -> int:
    return int(value.replace(",", ""))


def parse_totals_line(line: str):
    match = TOTAL_PATTERN.match(line)
    if not match:
        return None

    return {
        "Avg Sqft": parse_float(match.group(1)),
        "Avg Market": parse_float(match.group(2)),
        "Avg $/Sqft": parse_float(match.group(3)),
        "Total Units": parse_int(match.group(4)),
        "Total Leased": parse_int(match.group(5)),
        "Total Available": parse_int(match.group(6)),
        "Total Other": parse_int(match.group(7)),
        "Occupancy %": parse_float(match.group(8)),
        "Move Ins": parse_int(match.group(9)),
        "Move Outs": parse_int(match.group(10)),
        "Turn Over": parse_int(match.group(11)),
        "Notice Given": parse_int(match.group(12)),
    }


# ===========================================
# EXTRACTION
# ===========================================


def extract_property_status(pdf_file) -> pd.DataFrame:
    """Extract the occupancy Totals row for every property in the report.

    Identical parsing rules to before, wrapped in a function so the automated
    pipeline can reuse it without triggering the script's side effects.
    """
    rows = []

    current_property = ""
    current_code = ""
    inside_occupancy = False
    captured_totals = False

    with pdfplumber.open(str(pdf_file)) as pdf:

        for page in pdf.pages:

            text = page.extract_text() or ""

            if not text:
                continue

            lines = text.split("\n")

            for line in lines:

                line = line.strip()

                # ---------------------------------------
                # Detect Property Header
                # ---------------------------------------

                m = HEADER_PATTERN.match(line)

                if m:

                    property_name = m.group(1).strip()
                    property_code = m.group(2).strip()

                    # Repeated headers for the same property can appear on later
                    # pages. Only reset state when moving to a new property.
                    if property_code != current_code:

                        current_property = property_name
                        current_code = property_code
                        inside_occupancy = False
                        captured_totals = False

                    continue

                # ---------------------------------------
                # Start Occupancy Section
                # ---------------------------------------

                if OCCUPANCY_START_MARKER in line:

                    inside_occupancy = True
                    continue

                # ---------------------------------------
                # Stop once Projected Occupancy starts
                # ---------------------------------------

                if any(marker in line for marker in OCCUPANCY_END_MARKERS):

                    inside_occupancy = False
                    continue

                # ---------------------------------------
                # Extract Totals
                # ---------------------------------------

                if (
                    inside_occupancy
                    and not captured_totals
                    and line.startswith("Totals")
                ):

                    totals = parse_totals_line(line)

                    if totals:

                        rows.append({
                            "Property Code": current_code,
                            "Property Name": current_property,
                            **totals,
                        })

                        captured_totals = True

    return pd.DataFrame(rows)


# ===========================================
# SAVE
# ===========================================


def main() -> None:

    df = extract_property_status(pdf_path)

    for _, row in df.iterrows():
        # Plain ASCII marker: the Windows console defaults to cp1252 and
        # cannot encode a check mark.
        print(f"[OK] {row['Property Name']}")

    df.to_excel(output_excel, index=False)

    print()
    print(df.head())
    print()
    print(f"Properties Extracted : {len(df)}")


if __name__ == "__main__":
    main()


