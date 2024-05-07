import pdfplumber
import re
import pandas as pd

# Open the PDF file
with pdfplumber.open("C:/Users/Darshan.Singh/Documents/PDF2Excel/pdf/MRI_CMROLL_0326_LIGHT4MC.pdf") as pdf:
    # Initialize an empty list to store extracted values
    extracted_values = []

    # Iterate through each page in the PDF
    for page in pdf.pages:
        # Extract text from the page
        page_text = page.extract_text()

        # Define the regex pattern
        regex_pattern = r"^(\S+)\s+(\S+\S+\S+)"

        # Search for the pattern in the extracted text
        matches = re.findall(regex_pattern, page_text, re.MULTILINE)

        # Append the matches to the list of extracted values
        extracted_values.extend(matches)

# Convert the list of tuples to a DataFrame
df = pd.DataFrame(extracted_values, columns=["Column1", "Column2"])

# Specify the file path where you want to save the Excel file
file_path = "C:/Users/Darshan.Singh/Documents/PDF2Excel/excel/output.xlsx"

# Write the DataFrame to an Excel file
df.to_excel(file_path, index=False)

print(f"Extracted values have been saved to '{file_path}'")
