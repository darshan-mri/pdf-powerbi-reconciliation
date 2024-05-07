import pdfplumber
import pandas as pd

# Path to your PDF file
pdf_path = "/files/pdf/MRI_CMROLL_0326_LIGHT4MC.pdf"

# Initialize an empty list to store rows
rows = []

# Open the PDF file
with pdfplumber.open(pdf_path) as pdf:
    # Iterate through each page
    for page in pdf.pages:
        # Extract tables from the page
        tables = page.extract_tables()
        #print("Extracted Text:"+ tables)
        # Extract rows from each table and append to the list
        for table in tables:
            max_columns = max(len(row) for row in table)
            for row in table:
                # Pad rows with fewer columns to match the maximum number of columns
                if len(row) < max_columns:
                    row += [''] * (max_columns - len(row))
                rows.append(row)

# Create a DataFrame from the list of rows
combined_df = pd.DataFrame(rows)

# Write the combined DataFrame to an Excel file
combined_df.to_excel("C:/Users/Darshan.Singh/Documents/PDF2Excel/excel/converted.xlsx", index=False)

print("DataFrames have been written to 'converted.xlsx'")

# import pandas as pd
# import re
#
# # Read the Excel file into a DataFrame
# df = pd.read_excel("C:/Users/Darshan.Singh/Documents/PDF2Excel/excel/converted.xlsx")
#
# # Get the name of the first column
# first_column_name = df.columns[0]
#
# # Define multiple regex patterns
# regex_pattern1 = r"(\S+)\s+(\S+)\s+(\S+)\s+(\d{1,2}/\d{1,2}/\d{4})+\s+(\d{1,2}/\d{1,2}/\d{4})+\s+([\d,.]+)\s+([\d,.]+)\s+([\d,.]+)\s+([\d,.]+)\s+([\d,.]+)"
# regex_pattern2 = r"(\S+)\s+(\S+)\s+(\S+)\s+(\d{1,2}/\d{1,2}/\d{4})+\s+(\d{1,2}/\d{1,2}/\d{4})+\s+([\d,.]+)\s+([\d,.]+)"
# regex_pattern3 = r"(\S+)\s+(\S+)\s+(\S+)\s+(\d{1,2}\/\d{1,2}\/\d{4})+\s+(\d{1,2}\/\d{1,2}\/\d{4})+\s+([\d,.]+)\s+([\d,.]+)"
# regex_pattern4 = r"(\S+)\s+(\S+)\s+(\S+)\s+(\d{1,2}\/\d{1,2}\/\d{4})+\s+(\d{1,2}\/\d{1,2}\/\d{4})+\s+([\d,.]+)"
# regex_pattern5 = r"(\S+)\s+(\S+)\s+(\S+)\s+(\S+)"
#
# # Add more patterns if needed
#
# # Combine the regex patterns using the '|' (pipe) operator
# combined_regex_pattern = f"({'|'.join([regex_pattern1, regex_pattern2, regex_pattern3, regex_pattern4])})"
#
# # Extract the values from the first column using the regex patterns
# matches = df[first_column_name].str.extract(combined_regex_pattern)
#
# # Rename the columns of the matches DataFrame
# matches.columns = ['Column1', 'Column2', 'Column3', 'Column4', 'Column5', 'Column6', 'Column7', 'Column8', 'Column9', 'Column10']
#
# # Remove empty rows
# matches = matches.dropna()
#
# # Filter out rows starting with "Total" in the first column
# matches = matches[~matches['Column1'].str.startswith("Total")]
#
# # Insert empty cells next to "Vacant" in the third column
# for index, row in matches.iterrows():
#     if row['Column3'] == 'Vacant':
#         matches.iloc[index, 4:6] = [None, None]
#
#
# # Write the matches DataFrame to another Excel file
# matches.to_excel("C:/Users/Darshan.Singh/Documents/PDF2Excel/excel/cm_extracted.xlsx", index=False)
#
# print("Values from the first column have been extracted and stored in separate columns in 'output_excel.xlsx'")

