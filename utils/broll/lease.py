# ======================================================
# Configuration
# ======================================================
from utils.config_util import Config
import pdfplumber
import pandas as pd
import re

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

# ===========================================
# Helpers
# ===========================================

date_pattern = re.compile(r"\d{2}\s[A-Za-z]{3}\s\d{4}")

rows = []

# ===========================================
# Read PDF
# ===========================================

with pdfplumber.open(pdf_path) as pdf:

    for page_no, page in enumerate(pdf.pages, start=1):

        text = page.extract_text()

        if not text:
            continue

        lines = text.split("\n")

        for line in lines:

            line = " ".join(line.split())

            # Skip unwanted lines
            if (
                line.startswith("Tenant Lease Profile")
                or line.startswith("Floor Description")
                or line.startswith("LEGEND")
                or line.startswith("Notes")
                or line.startswith("Premises")
                or line.startswith("Printed")
                or line.startswith("Page ")
                or line.strip() == ""
            ):
                continue

            # Find first date
            m = date_pattern.search(line)

            if not m:
                continue

            date_start = m.start()

            left = line[:date_start].strip()
            right = line[date_start:].strip()

            tokens = left.split()

            if len(tokens) < 2:
                continue

            # Premises = first token(s)
            premises = tokens[0]

            # Trading name = everything after premises
            trading_name = " ".join(tokens[1:])

            # Split right side
            right_tokens = right.split()

            if len(right_tokens) < 8:
                continue

            lease_start = " ".join(right_tokens[:3])
            lease_end = " ".join(right_tokens[3:6])

            remaining = right_tokens[6:]

            vacant = ""
            leased_area = ""
            rental_basic = ""

            numbers = []

            for token in remaining:
                t = token.replace(",", "")
                try:
                    float(t)
                    numbers.append(token)
                except:
                    pass

            if len(numbers) >= 3:
                vacant = numbers[0]
                leased_area = numbers[1]
                rental_basic = numbers[2]

            rows.append({
                "Premises": premises,
                "Trading Name": trading_name,
                "Vacant": vacant,
                "Leased Area": leased_area,
                "Lease Start": lease_start,
                "Lease End": lease_end,
                "Rental Basic": rental_basic
            })

# ===========================================
# Export
# ===========================================

if not rows:
    print("No rows extracted.")
    exit()

df = pd.DataFrame(rows)

df.drop_duplicates(inplace=True)

df.to_excel(output_excel, index=False)

print(f"Rows extracted : {len(df)}")
print(f"Excel saved to : {output_excel}")