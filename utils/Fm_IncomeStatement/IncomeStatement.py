import pdfplumber
import pandas as pd
import re

# ======================================================
# Configuration
# ======================================================
from utils.config_util import Config

# ===========================================
# CONFIG
# ===========================================

cfg = Config()

pdf_path = cfg.get(
    section="FM_INCOME_STATEMENT",
    key="PDF"
)

output_excel = cfg.get(
    section="FM_INCOME_STATEMENT",
    key="EXCEL"
)


# ======================================================
# Regular Expressions
# ======================================================

entity_pattern = re.compile(r"^(.*?)\s*\(ENTITY:\s*(\d+)\)", re.IGNORECASE)

measure_pattern = re.compile(
    r"^\[\[(.*?)\]\](.*?)\s+(\(?-?[\d,]+\.\d+\)?)\s+(\(?-?[\d,]+\.\d+\)?)$"
)

normal_pattern = re.compile(
    r"^(.*?)\s+(\(?-?[\d,]+\.\d+\)?)\s+(\(?-?[\d,]+\.\d+\)?)$"
)

# ======================================================
# Main Headers
# ======================================================

HEADERS = [
    "OPERATING INCOME",
    "Expenses",
    "Other Expenses",
    "Assets",
    "Liabilities",
    "Equity",
    "Revenue",
    "Income",
]

# ======================================================
# Helper Function
# ======================================================

def clean_number(value):

    negative = "(" in value

    value = (
        value.replace(",", "")
        .replace("(", "")
        .replace(")", "")
    )

    try:
        number = float(value)
    except:
        number = None

    if negative and number is not None:
        number = -number

    return number


# ======================================================
# Read PDF
# ======================================================

records = []

with pdfplumber.open(pdf_path) as pdf:

    report_name = ""
    report_period = ""

    for page_no, page in enumerate(pdf.pages, start=1):

        text = page.extract_text()

        if not text:
            continue

        lines = [x.strip() for x in text.split("\n") if x.strip()]

        entity_name = ""
        entity_id = ""
        current_section = ""

        # -------------------------------------------
        # Get Report Name
        # -------------------------------------------

        for line in lines:

            if "Statement" in line or "Report" in line:

                if (
                    "Report ID" not in line
                    and "Reported by" not in line
                ):
                    report_name = line
                    break

        # -------------------------------------------
        # Get Period
        # -------------------------------------------

        for line in lines:

            if re.match(r"^[A-Z][a-z]{2}\s20\d\d$", line):

                report_period = line
                break

        # -------------------------------------------
        # Get Entity
        # -------------------------------------------

        for line in lines:

            m = entity_pattern.search(line)

            if m:

                entity_name = m.group(1).strip()
                entity_id = m.group(2)
                break

        # -------------------------------------------
        # Read Financial Rows
        # -------------------------------------------

        for line in lines:

            line = line.strip()

            # Skip unwanted rows
            if (
                line.startswith("Report ID")
                or line.startswith("Database")
                or line.startswith("Reported by")
                or line.startswith("Current Period")
                or line.startswith("Year-To-Date")
                or line.startswith("1 Month")
                or line.startswith("12 Months")
                or line.startswith("Accrual")
                or line.startswith("Page")
                or line == report_period
                or line == report_name
                or "ENTITY:" in line
            ):
                continue

            # Detect Section
            if line in HEADERS:

                current_section = line
                continue

            # -----------------------------------
            # Measure Code Present
            # -----------------------------------

            m = measure_pattern.match(line)

            if m:

                measure_code = m.group(1).strip()

                financial_item = m.group(2).strip()

                current = clean_number(m.group(3))

                ytd = clean_number(m.group(4))

                records.append({
                    "Page": page_no,
                    "Report Name": report_name,
                    "Report Period": report_period,
                    "EntityId": entity_id,
                    "EntityName": entity_name,
                    "Main Header": current_section,
                    "Measure Code": measure_code,
                    "Financial Format": financial_item,
                    "Current Period": current,
                    "YTD": ytd
                })

                continue

            # -----------------------------------
            # Without Measure Code
            # -----------------------------------

            m = normal_pattern.match(line)

            if m:

                financial_item = m.group(1).strip()

                current = clean_number(m.group(2))

                ytd = clean_number(m.group(3))

                records.append({

                    "Page": page_no,
                    "Report Name": report_name,
                    "Report Period": report_period,
                    "EntityId": entity_id,
                    "EntityName": entity_name,
                    "Main Header": current_section,
                    "Measure Code": "",
                    "Financial Format": financial_item,
                    "Current Period": current,
                    "YTD": ytd

                })

# ======================================================
# Create DataFrame
# ======================================================

df = pd.DataFrame(records)

df = df.sort_values(
    [
        "EntityId",
        "Main Header",
        "Financial Format"
    ]
)

# ======================================================
# Export Excel
# ======================================================

with pd.ExcelWriter(
    output_excel,
    engine="openpyxl"
) as writer:

    df.to_excel(
        writer,
        sheet_name="Income Statement",
        index=False
    )

    ws = writer.sheets["Income Statement"]

    for column in ws.columns:

        max_length = max(
            len(str(cell.value)) if cell.value else 0
            for cell in column
        )

        ws.column_dimensions[column[0].column_letter].width = max_length + 3

print("=" * 50)
print("Completed Successfully")
print("=" * 50)
print(f"Rows Extracted : {len(df)}")
print(f"Entities       : {df['EntityId'].nunique()}")
print(f"Excel Saved As : {output_excel}")