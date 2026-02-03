import pandas as pd

# Read the Excel files into Pandas DataFrames
df1 = pd.read_excel('C:/Users/Darshan.Singh/Documents/PDF2Excel/excel/rm_extracted_entity.xlsx')
df2 = pd.read_excel('C:/Users/Darshan.Singh/Documents/PDF2Excel/excel/reportTotals/EntityTotals.xlsx')

# Add a new column to indicate DataFrame origin
df1['Source'] = 'PDF'
df2['Source'] = 'Report'
0
# Find missing rows from df1 in df2
missing_rows_df1 = df1[~df1['EntityId'].isin(df2['EntityId'])]

# Find missing rows from df2 in df1
missing_rows_df2 = df2[~df2['EntityId'].isin(df1['EntityId'])]

# Concatenate missing rows from both DataFrames
missing_rows_combined = pd.concat([missing_rows_df1, missing_rows_df2])

# Reset the index of the combined DataFrame
missing_rows_combined.reset_index(drop=True, inplace=True)

# Specify the file path where you want to save the Excel file
file_path = "/files/excel/rm_ar_missing_records.xlsx"

# Write the combined DataFrame to an Excel file
missing_rows_combined.to_excel(file_path, index=False)

print(f"Missing rows have been saved to '{file_path}'")



