import camelot
import pandas as pd


def extract_tables_from_pdf(pdf_path):
    # Read tables from the PDF
    tables = camelot.read_pdf(pdf_path, flavor='stream', pages='all')

    # Initialize an empty list to store DataFrames
    dataframes = []

    # Convert each table to a DataFrame
    for table in tables:
        df = table.df
        # Split the text content of each cell by "\n"
        df = df.applymap(lambda x: x.split("\n") if isinstance(x, str) else x)
        # Expand lists into separate columns
        df_expanded = df.apply(lambda row: pd.Series([item for sublist in row for item in sublist]), axis=1)
        #Append the expanded DataFrame to the list
        dataframes.append(df_expanded)

    return dataframes


def filter_rows(df, column_index, keywords):
    """
    Filter out rows based on conditions on the specified column.

    Parameters:
    - df: DataFrame to filter
    - column_index: Index of the column to filter (0 for the first column, 1 for the second column, etc.)
    - keywords: List of keywords to filter out

    Returns:
    - Filtered DataFrame
    """
    # Filter out rows based on conditions on the specified column
    return df[~df[column_index].astype(str).str.contains('|'.join(keywords), case=False)]


def merge_columns_vacant(df):
    for i in range(len(df)):
        # Merge the value of the 2nd column with the 1st column value if the 3rd column value is "Vacant"
        if df.iloc[i, 2] == "Vacant":
            df.iloc[i, 0] = df.iloc[i, 0] + " " + df.iloc[i, 1]
            df.iloc[i, 1] = ""
            # Shift values one cell to the left starting from the third column
            df.iloc[i, 1:-1] = df.iloc[i, 2:].values
            df.iloc[i, -1] = ""  # Set the last cell to an empty string
    return df


def merge_columns_not_date(df):
    for i in range(len(df)):
        # Merge the value of the 3rd column with the 2nd column value if the 3rd column value is not a valid date
        if pd.isnull(pd.to_datetime(df.iloc[i, 2], errors='coerce')) and df.iloc[i, 2]:
            df.iloc[i, 1] = df.iloc[i, 1] + " " + df.iloc[i, 2]
            df.iloc[i, 2] = ""
            # Shift values one cell to the left starting from the fourth column
            df.iloc[i, 2:-1] = df.iloc[i, 3:].values
            df.iloc[i, -1] = ""  # Set the last cell to an empty string
    return df


def main():
    # Path to the PDF file
    pdf_path = "C:/Users/Darshan.Singh/Documents/PDF2Excel/files/pdf/MRI_CMROLL_0326_LIGHT4MC.pdf"

    # Extract tables from the PDF
    dataframes = extract_tables_from_pdf(pdf_path)

    # # Filter rows for each DataFrame
    # filtered_dataframes = [filter_rows(df) for df in dataframes]

    # Filter rows for each DataFrame based on the first column
    filtered_dataframes_first_column = [
        filter_rows(df, 0, ['Database', 'New', 'Bldg', 'Occupied', 'Vacant', 'Leased', 'Total', 'Area', '^$']) for df in
        dataframes]

    # Filter rows for each DataFrame based on the second column
    filtered_dataframes_second_column = [filter_rows(df, 1, ['Forsight', 'test']) for df in
                                         filtered_dataframes_first_column]

    # Merge columns for each DataFrame
    merged_dataframes = [merge_columns_vacant(df) for df in filtered_dataframes_second_column]
    merged_dataframes = [merge_columns_not_date(df) for df in merged_dataframes]

    # Concatenate all DataFrames into a single DataFrame
    combined_df = pd.concat(merged_dataframes, ignore_index=True)

    # Remove any empty rows and columns
    combined_df = combined_df.dropna(how='all')
    combined_df = combined_df.dropna(axis=1, how='all')

    # print("DataFrame shape:", combined_df.shape)
    # print("First few rows:")
    # print(combined_df.head())

    # Path to the Excel file
    excel_file = "C:/Users/Darshan.Singh/Documents/PDF2Excel/files/excel/output.xlsx"

    # Write the combined DataFrame to the Excel file
    combined_df.to_excel(excel_file, index=False)

    print(f"All tables have been written to '{excel_file}'")


if __name__ == "__main__":
    main()
