import pandas as pd

# Load the first DataFrame from the first Excel file
df1 = pd.read_excel("C:/Users/Darshan.Singh/Documents/PDF2Excel/excel/rm_extracted_entity.xlsx")

# Load the second DataFrame from the second Excel file
df2 = pd.read_excel("C:/Users/Darshan.Singh/Documents/PDF2Excel/excel/EntityTotals.xlsx")

# Align the DataFrames to have the same column names and index labels
df1_aligned = df1.reindex(columns=df2.columns, index=df2.index)

# Perform the comparison
comparison_result = (df1_aligned == df2)

# Reset the index of the comparison result DataFrame
comparison_result = comparison_result.reset_index(drop=True)

# Get the values of the first column from df1
column_values = df1.iloc[:, 0]

# Assign the values from the first column of df1 as a new column in the comparison result DataFrame
comparison_result["EntityId"] = column_values

# Write the comparison result to a new Excel file
comparison_result.to_excel("C:/Users/Darshan.Singh/Documents/PDF2Excel/excel/comparison_results.xlsx", index=False)

print("Comparison result saved to 'comparison_results.xlsx'")
