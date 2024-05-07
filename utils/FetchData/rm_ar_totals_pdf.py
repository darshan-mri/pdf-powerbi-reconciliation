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

import pdfplumber
import re
import pandas as pd

# Open the PDF file
with pdfplumber.open("/files/pdf/MRI_RMAGEDEL_0326_LIGHT4MC.pdf") as pdf:
    # Initialize an empty list to store extracted data
    all_data = []

    # Define regex patterns
    #occupant_total_regex_pattern = r"([a-zA-Z]*,\s*[a-zA-Z]*\s*[a-zA-Z]*\.*)\s*Total:\s+(\-*[\d,]+\.*\d{2}?)\s+(\-*[\d,]+\.*\d{2}?)\s+(\-*[\d,]+\.*\d{2}?)\s+(\-*[\d,]+\.*\d{2}?)\s+(\-*[\d,]+\.*\d{2}?)\s+(\-*[\d,]+\.*\d{2}?)"
    occupant_total_regex_pattern = (
        r"([a-zA-Z]*,\s*[a-zA-Z]*\s*[a-zA-Z]*\.*)"  # Occupant name
        r"\s*Total:\s+(\-*[\d,]+\.*\d{2}?)\s+"  # Total Amount
        r"(\-*[\d,]+\.*\d{2}?)\s+"  # Total Current
        r"(\-*[\d,]+\.*\d{2}?)\s+"  # Total 30
        r"(\-*[\d,]+\.*\d{2}?)\s+"  # Total 60
        r"(\-*[\d,]+\.*\d{2}?)\s+"  # Total 90
        r"(\-*[\d,]+\.*\d{2}?)"  # Total 120
    )
    #entity_total_regex_pattern = r"ENTITY\s*(\S+)\s*Total:\s(\-*[\d,]+\.*\d{2}?)\s(\-*[\d,]+\.*\d{2}?)\s(\-*[\d,]+\.*\d{2}?)\s(\-*[\d,]+\.*\d{2}?)\s(\-*[\d,]+\.*\d{2}?)\s(\-*[\d,]+\.*\d{2}?)"
    entity_total_regex_pattern = (
        r"ENTITY\s*(\S+)\s*"  # Entity name
        r"Total:\s+(\-*[\d,]+\.*\d{2}?)\s"  # Total Amount
        r"(\-*[\d,]+\.*\d{2}?)\s"  # Total Current
        r"(\-*[\d,]+\.*\d{2}?)\s"  # Total 30
        r"(\-*[\d,]+\.*\d{2}?)\s"  # Total 60
        r"(\-*[\d,]+\.*\d{2}?)\s"  # Total 90
        r"(\-*[\d,]+\.*\d{2}?)"  # Total 120
    )

    # Iterate through each page in the PDF
    for page in pdf.pages:
        # Extract text from the page
        page_text = page.extract_text()

        # Search for occupant and entity data
        occupant_match = re.findall(occupant_total_regex_pattern, page_text)
        entity_match = re.findall(entity_total_regex_pattern, page_text)

        # Append occupant data to all_data list
        for i in occupant_match:
            all_data.append(("Occupant",) + i)

        # Append entity data to all_data list
        for i in entity_match:
            all_data.append(("Entity",) + i)

# Create a DataFrame from the collected data
df = pd.DataFrame(all_data,
                  columns=["Type", "Name", "Total Amount", "Total Current", "Total 30", "Total 60", "Total 90",
                           "Total 120"])

# Split DataFrame into occupant and entity DataFrames
occupant_df = df[df["Type"] == "Occupant"].drop(columns=["Type"])
entity_df = df[df["Type"] == "Entity"].drop(columns=["Type"])

# Write DataFrames to Excel files
occupant_df.to_excel("C:/Users/Darshan.Singh/Documents/PDF2Excel/excel/rm_extracted_occupant.xlsx", index=False)
entity_df.to_excel("C:/Users/Darshan.Singh/Documents/PDF2Excel/excel/rm_extracted_entity.xlsx", index=False)

print("Data saved to 'extracted_occupant.xlsx'")
print("Data saved to 'extracted_entity.xlsx'")
