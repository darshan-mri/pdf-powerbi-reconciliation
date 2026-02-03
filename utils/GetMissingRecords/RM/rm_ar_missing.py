import pandas as pd
from utils.config_util import Config

# Create a Config instance (singleton pattern)
config = Config()

def find_missing_rows(df1_path, df2_path, key_column, output_path):
    # Read the Excel files into Pandas DataFrames
    df1 = pd.read_excel(df1_path)
    df2 = pd.read_excel(df2_path)

    # Add a new column to indicate DataFrame origin
    df1['Source'] = 'PDF'
    df2['Source'] = 'Report'

    # Find missing rows from df1 in df2
    missing_rows_df1 = df1[~df1[key_column].isin(df2[key_column])]

    # Find missing rows from df2 in df1
    missing_rows_df2 = df2[~df2[key_column].isin(df1[key_column])]

    # Concatenate missing rows from both DataFrames
    missing_rows_combined = pd.concat([missing_rows_df1, missing_rows_df2])

    # Reset the index of the combined DataFrame
    missing_rows_combined.reset_index(drop=True, inplace=True)

    # Write the combined DataFrame to an Excel file
    missing_rows_combined.to_excel(output_path, index=False)

    print(f"Missing rows have been saved to '{output_path}'")

# Specify the file paths and key column for each comparison
comparisons = [
    {
        'df1_path': config.get('RM.AR', 'ExtractedEntity'),
        'df2_path': config.get('RM.AR', 'EntityTotals'),
        'key_column': 'EntityId',
        'output_path': config.get('RM.AR', 'EntityMissingRecords')
    },
    {
        'df1_path': config.get('RM.AR', 'ExtractedOccupant'),
        'df2_path': config.get('RM.AR', 'OccupantTotals'),
        'key_column': 'Name',
        'output_path': config.get('RM.AR', 'OccupantMissingRecords')
    }
]

# Iterate over each comparison and call the function
for comparison in comparisons:
    find_missing_rows(comparison['df1_path'], comparison['df2_path'], comparison['key_column'], comparison['output_path'])
