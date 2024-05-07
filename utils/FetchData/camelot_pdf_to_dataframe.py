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

def filter_rows(df):
    # Filter out rows based on conditions on the first column
    return df[~df[0].astype(str).str.contains('Database|New|Bldg|Occupied|Vacant|Leased|Total|Area|^$')]

def merge_columns(df):
    # Merge the value of the 2nd column with the 1st column value by space if the 3rd column value is "Vacant"
    for i in range(len(df)):
        if df.iloc[i, 2] == "Vacant":
            df.iloc[i, 0] = df.iloc[i, 0] + " " + df.iloc[i, 1]
            df.iloc[i, 1] = ""
        elif pd.to_datetime(df.iloc[i, 2], errors='coerce') is pd.NaT:
            # If the value in the 3rd column is not a date, shift the values in the row one cell to the left
            df.iloc[i, :-1] = df.iloc[i, 1:]
            df.iloc[i, -1] = ""  # Set the last cell to an empty string
    return df


def main():
    # Path to the PDF file
    pdf_path = "/files/pdf/MRI_CMROLL_0326_LIGHT4MC.pdf"

    # Extract tables from the PDF
    dataframes = extract_tables_from_pdf(pdf_path)

    # Filter rows for each DataFrame
    filtered_dataframes = [filter_rows(df) for df in dataframes]

    # Merge columns for each DataFrame
    merged_dataframes = [merge_columns(df) for df in filtered_dataframes]

    # Concatenate all DataFrames into a single DataFrame
    combined_df = pd.concat(merged_dataframes, ignore_index=True)

    # Remove any empty rows and columns
    combined_df = combined_df.dropna(how='all')
    combined_df = combined_df.dropna(axis=1, how='all')

    # print("DataFrame shape:", combined_df.shape)
    # print("First few rows:")
    # print(combined_df.head())

    # Path to the Excel file
    excel_file = "/files/excel/output.xlsx"

    # Write the combined DataFrame to the Excel file
    combined_df.to_excel(excel_file, index=False)

    print(f"All tables have been written to '{excel_file}'")

if __name__ == "__main__":
    main()


