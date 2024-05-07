import pandas as pd

# Load the Excel file into a DataFrame
df = pd.read_excel("C:/Users/Darshan.Singh/Documents/PDF2Excel/excel/your_excel_file.xlsx")

# Delete columns
columns_to_delete = ['Column1', 'Column2']  # Specify the columns to delete
df.drop(columns=columns_to_delete, inplace=True)

# Rename columns
new_column_names = {'OldColumnName1': 'NewColumnName1', 'OldColumnName2': 'NewColumnName2'}  # Specify the new column names
df.rename(columns=new_column_names, inplace=True)

# Write the modified DataFrame back to the same Excel file, overwriting it
df.to_excel("C:/Users/Darshan.Singh/Documents/PDF2Excel/excel/your_excel_file.xlsx", index=False)
