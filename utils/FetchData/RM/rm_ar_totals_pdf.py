# import pdfplumber
# import re
# import pandas as pd
#
# # Open the PDF file
# with pdfplumber.open("C:/Users/Darshan.Singh/Documents/PDF2Excel/pdf/MRI_RMAGEDEL_0326_LIGHT4MC.pdf") as pdf:
#     # Initialize empty lists to store extracted names and total amounts
#     names = []
#     occupant_total_amount = []
#     occupant_total_current = []
#     occupant_total_30 = []
#     occupant_total_60 = []
#     occupant_total_90 = []
#     occupant_total_120 = []
#
#     entities = []
#     entity_total_amount = []
#     entity_total_current = []
#     entity_total_30 = []
#     entity_total_60 = []
#     entity_total_90 = []
#     entity_total_120 = []
#
#     # Iterate through each page in the PDF
#     for page in pdf.pages:
#         # Extract text from the page
#         page_text = page.extract_text()
#         #print("Extracted Text:"+ page_text)
#
#         # Define the regex pattern to search for
#         occupant_total_regex_pattern = r"([a-zA-Z]*,\s*[a-zA-Z]*\s*[a-zA-Z]*\.*)\s*Total:\s+(\-*[\d,]+\.*\d{2}?)\s+(\-*[\d,]+\.*\d{2}?)\s+(\-*[\d,]+\.*\d{2}?)\s+(\-*[\d,]+\.*\d{2}?)\s+(\-*[\d,]+\.*\d{2}?)\s+(\-*[\d,]+\.*\d{2}?)"
#         entity_total_regex_pattern = r"ENTITY\s*(\S+)\s*Total:\s(\-*[\d,]+\.*\d{2})?\s(\-*[\d,]+\.*\d{2})?\s(\-*[\d,]+\.*\d{2})?\s(\-*[\d,]+\.*\d{2})?\s(\-*[\d,]+\.*\d{2})?\s(\-*[\d,]+\.*\d{2})?"
#         #regex_pattern = r"Total:\s+([\d,]+\.\d{2})"
#
#         # Search for the pattern in the extracted text
#         #match = re.search(regex_pattern, page_text)
#         occupant_match = re.findall(occupant_total_regex_pattern, page_text)
#         entity_match = re.findall(entity_total_regex_pattern, page_text)
#
#         # If a match is found, extract the entity and total
#         if entity_match:
#             # Append the extracted entity and total amount to the lists
#             # for i in match:
#             # entity = [item[0] for item in entity_match]
#             # entity_total = [item[1] for item in entity_match]
#
#             for i in entity_match:
#                 entities.append(i[0])
#                 entity_total_amount.append((i[1]))
#                 entity_total_current.append((i[2]))
#                 entity_total_30.append((i[3]))
#                 entity_total_60.append((i[4]))
#                 entity_total_90.append((i[5]))
#                 entity_total_120.append((i[6]))
#         #If a match is found, extract the name and total amount
#         if occupant_match:
#             # Append the extracted name and total amount to the lists
#             #for i in match:
#             #name = [item[0] for item in occupant_match]
#             #total_amount = [item[1] for item in occupant_match]
#
#             for i in occupant_match:
#                 names.append(i[0])
#                 occupant_total_amount.append((i[1]))
#                 occupant_total_current.append((i[2]))
#                 occupant_total_30.append((i[3]))
#                 occupant_total_60.append((i[4]))
#                 occupant_total_90.append((i[5]))
#                 occupant_total_120.append((i[6]))
#             #names.append(item for item in name)
#             #total_amounts.append(item for item in total_amount)
#
#             #names.append(name)
#             #total_amounts.append(total_amount)
#
#     # Create a DataFrame to store the extracted data
#     df1 = pd.DataFrame({
#         "Name": names,
#         "Total Amount": occupant_total_amount,
#         "Total Current": occupant_total_current,
#         "Total 30": occupant_total_30,
#         "Total 60": occupant_total_60,
#         "Total 90": occupant_total_90,
#         "Total 120": occupant_total_120
#     })
#
#     # Create a DataFrame to store the extracted data
#     df2 = pd.DataFrame({
#         "EntityName": entities,
#         "Total Amount": entity_total_amount,
#         "Total Current": entity_total_current,
#         "Total 30": entity_total_30,
#         "Total 60": entity_total_60,
#         "Total 90": entity_total_90,
#         "Total 120": entity_total_120
#     })
#
#     # Write the DataFrame to an Excel file
#     df1.to_excel("C:/Users/Darshan.Singh/Documents/PDF2Excel/excel/extracted_occupant.xlsx", index=False)
#     df2.to_excel("C:/Users/Darshan.Singh/Documents/PDF2Excel/excel/extracted_entity.xlsx", index=False)
#     print("Data saved to 'extracted_occupant.xlsx'")
#     print("Data saved to 'extracted_entity.xlsx'")

# -----------------------------------------------------------------------------------------------------------------
import re
import time
import pdfplumber
import pandas as pd
from pathlib import Path
from utils.config_util import Config

# ------------------------
# Main extraction script
# ------------------------
def main():
    start_time = time.time()
    config = Config()

    # ------------------------
    # Get paths from config (automatically resolved)
    # ------------------------
    pdf_path = config.get("RM.AR", "PDF")
    occupant_path = config.get("RM.AR", "ExtractedOccupant")
    entity_path = config.get("RM.AR", "ExtractedEntity")

    # Debug info
    print("Script file:", __file__)
    print("Resolved PDF Path:", pdf_path)
    print("Resolved Occupant Excel Path:", occupant_path)
    print("Resolved Entity Excel Path:", entity_path)

    # Check if PDF exists
    if not Path(pdf_path).exists():
        raise FileNotFoundError(f"PDF file not found at: {pdf_path}")

    all_data = []

    # ------------------------
    # Regex patterns
    # ------------------------
    occupant_total_regex_pattern = (
        r"([a-zA-Z]*,\s*[a-zA-Z]*\s*[a-zA-Z]*\.*)"
        r"\s*Total:\s+(\-*[\d,]+\.*\d{2}?)\s+"
        r"(\-*[\d,]+\.*\d{2}?)\s+"
        r"(\-*[\d,]+\.*\d{2}?)\s+"
        r"(\-*[\d,]+\.*\d{2}?)\s+"
        r"(\-*[\d,]+\.*\d{2}?)\s+"
        r"(\-*[\d,]+\.*\d{2}?)"
    )

    entity_total_regex_pattern = (
        r"ENTITY\s*(\S+)\s*"
        r"Total:\s+(\-*[\d,]+\.*\d{2}?)\s"
        r"(\-*[\d,]+\.*\d{2}?)\s"
        r"(\-*[\d,]+\.*\d{2}?)\s"
        r"(\-*[\d,]+\.*\d{2}?)\s"
        r"(\-*[\d,]+\.*\d{2}?)\s"
        r"(\-*[\d,]+\.*\d{2}?)"
    )

    # ------------------------
    # Extract PDF data
    # ------------------------
    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages:
            page_text = page.extract_text() or ""

            occupant_match = re.findall(occupant_total_regex_pattern, page_text)
            entity_match = re.findall(entity_total_regex_pattern, page_text)

            for i in occupant_match:
                all_data.append(("Occupant",) + i)
            for i in entity_match:
                all_data.append(("Entity",) + i)

    # ------------------------
    # Convert to DataFrame
    # ------------------------
    df = pd.DataFrame(
        all_data,
        columns=[
            "Type", "Name", "Total Amount", "Total Current",
            "Total 30", "Total 60", "Total 90", "Total 120"
        ]
    )

    occupant_df = df[df["Type"] == "Occupant"].drop(columns=["Type"])
    entity_df = df[df["Type"] == "Entity"].drop(columns=["Type"])

    # ------------------------
    # Save outputs
    # ------------------------
    occupant_df.to_excel(occupant_path, index=False)
    entity_df.to_excel(entity_path, index=False)

    elapsed = round(time.time() - start_time, 2)
    print(f"Data saved to:\n- {occupant_path}\n- {entity_path}")
    print(f"Time taken for conversion: {elapsed} seconds")


if __name__ == "__main__":
    main()
