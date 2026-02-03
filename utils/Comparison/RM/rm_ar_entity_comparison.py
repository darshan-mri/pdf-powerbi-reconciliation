import pandas as pd
from utils.config_util import Config

# Create a Config instance (singleton pattern)
config = Config()

# Load the first DataFrame from the first Excel file
#df1 = pd.read_excel(config.get('RM.AR', 'ExtractedEntity'))
df1 = pd.read_excel(config.get('RM.AR', 'ExtractedOccupant'))

# Load the second DataFrame from the second Excel file
#df2 = pd.read_excel(config.get('RM.AR', 'EntityTotals'))
df2 = pd.read_excel(config.get('RM.AR', 'OccupantTotals'))

# # Replace empty strings with NaN
# df2.replace('', pd.NA, inplace=True)
#
# # Replace NaN values with 0
# df2.fillna(0, inplace=True)

# Function to normalize a DataFrame by removing commas and converting to numeric
def normalize_df(df):
    def convert_value(value):
        if isinstance(value, str):
            try:
                # Remove commas and convert to a numeric value
                return pd.to_numeric(value.replace(',', ''))
            except ValueError:
                # If conversion fails, return the original value
                return value
        return value

    # Apply the conversion function to each column using `apply` with `map`
    return df.apply(lambda col: col.map(convert_value) if col.dtype == 'object' else col)


# Normalize both DataFrames
df1_normalized = normalize_df(df1)
df2_normalized = normalize_df(df2)

# Ensure columns and indices match before comparison
if not df1_normalized.columns.equals(df2_normalized.columns):
    print("Columns do not match. Reordering columns.")
    df1_normalized = df1_normalized[df2_normalized.columns]

if not df1_normalized.index.equals(df2_normalized.index):
    print("Indices do not match. Reordering indices.")
    df1_normalized = df1_normalized.reindex(df2_normalized.index)

# Now compare the normalized DataFrames
comparison_result = df1_normalized == df2_normalized

# # # Align the DataFrames to have the same column names and index labels
# # df1_aligned = df1_normalized.reindex(columns=df2_normalized.columns, index=df2_normalized.index)
#
# # Ensure both DataFrames have the same index and columns before comparison
# df1_normalized = df1_normalized.reindex_like(df2_normalized)
#
# # Perform the comparison of normalized DataFrames
# comparison_result = (df1_normalized == df2_normalized)

# Reset the index of the comparison result DataFrame
comparison_result = comparison_result.reset_index(drop=True)

# Get the values of the first column from df1
column_values = df1.iloc[:, 0]

# Assign the values from the first column of df1 as a new column in the comparison result DataFrame
#comparison_result["EntityId"] = column_values
comparison_result["Name"] = column_values

# Write the comparison result to a new Excel file
comparison_result.to_excel(config.get('RM.AR', 'ComparisonResult'), index=False)

print("Comparison result saved to 'comparison_results.xlsx'")
