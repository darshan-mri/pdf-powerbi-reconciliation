# PDFValidation

Tools for extracting data from property management PDFs (aged delinquencies, ledgers, rent rolls, income statements) and validating it against Excel reports.

## Getting Started

### 1. Prerequisites

- Windows machine (paths and sample files in this repo are Windows-oriented)
- Python 3.10+ installed and available on your PATH
- Git installed (to clone the repository)

Check Python:

```powershell
python --version
```

### 2. Clone the repository

```powershell
cd C:\
git clone https://github.com/darshan-mri/PDFValidation.git
cd PDFValidation
```


### 3. Create and activate a virtual environment

From the project root (`C:\PDFValidation`):

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

You should see `(.venv)` in your PowerShell prompt.

### 4. Install dependencies

With the virtual environment active, install the required Python packages:

```powershell
pip install --upgrade pip
pip install -r requirements.txt
```

This installs the libraries used throughout the project:

- `camelot_py` – PDF table extraction
- `pandas` – data processing and Excel I/O
- `pdfplumber` – PDF text and layout parsing
- `openpyxl` – Excel writing and formatting
- `PyPDF2` – PDF reading for some CM scripts

### 5. Configure `config.ini`

The project uses a central configuration file at the repo root: `config.ini`.

It defines input and output paths for different workflows, such as:

- Aged receivables (RM)
- CM ledgers and aged reports
- CM rent rolls
- Financial metrics variance / income statements

A new user should:

1. Open `config.ini` in an editor.
2. For the sections they intend to run (e.g. `RM.AR`, `CM.ROLL`, `CM.LEDGER`, `FM.VARIANCE`, `CM.AGED`), ensure the paths point to real files under `files/pdf` and `files/excel`.

Example pattern (adjust to match the actual sections/keys in your `config.ini`):

```ini
[CM.ROLL]
PDF = files/pdf/CM_RENT_ROLL_202505.pdf
ExtractedBuilding = files/excel/cm_extracted_suites.xlsx

[CM.LEDGER]
PDF = files/pdf/LEDGERS_0525 1-US.pdf
BillingsExcel = files/excel/BillingDetails.xlsx
CreditsExcel = files/excel/CreditDetails.xlsx
CombinedExcel = files/excel/BillingCreditCombined.xlsx
```

Notes:

- Paths can be relative; they are resolved from the project root by `utils.config_util.Config`.
- Make sure every configured file actually exists (either from the repo's sample `files/` folder or your own data).

### 6. Run a quick smoke test

Once dependencies are installed and `config.ini` is set up, you can run one or more scripts to verify things work end‑to‑end.

Always activate the virtual environment first:

```powershell
cd C:\PDFValidation
.\.venv\Scripts\Activate.ps1
```

#### Example A: CM Rent Roll Extraction

```powershell
python -m utils.FetchData.CM.cm_rent_roll
```

This script:

- Reads the CM rent roll PDF configured under `[CM.ROLL] / PDF`.
- Parses totals and other metrics by building.
- Writes an Excel file to the path configured as `[CM.ROLL] / ExtractedBuilding`.

#### Example B: Financial Details Result Formatting

This expects a comparison Excel with `MTD_Comparison` and `YTD_Comparison` sheets, typically produced by the FM variance comparison workflow.

```powershell
python -m utils.FetchData.FM.financial_details_result_format
```

This script:

- Reads the comparison output at `[FM.VARIANCE] / ComparisonResult`.
- Builds a "Financial Details" sheet.
- Applies formatting (bold headers, shading, match highlighting, column widths).
- Creates summary sheets for key metrics.

### 7. Other useful scripts

Some additional entry points you may use:

- **Combine Billings + Credits Excel**
  - Module: `utils.FetchData.CM.combine_billings_credits_excel`
  - Command:
    ```powershell
    python -m utils.FetchData.CM.combine_billings_credits_excel
    ```
  - Uses `[CM.LEDGER]` paths in `config.ini` to combine two Excel exports and save a unified file.

- **CM Ledger Totals Extraction**
  - Module: `utils.FetchData.CM.cm_ledger`
  - Command:
    ```powershell
    python -m utils.FetchData.CM.cm_ledger
    ```
  - Uses `pdfplumber` to extract building and lease totals from CM ledger PDFs.

- **RM A/R Entity / Occupant Comparison**
  - Module: `utils.Comparison.RM.rm_ar_entity_comparison`
  - Command:
    ```powershell
    python -m utils.Comparison.RM.rm_ar_entity_comparison
    ```
  - Compares two Excel outputs (extracted vs totals) defined in `[RM.AR]`.

### 8. Typical workflow

A typical daily flow for a user might look like:

```powershell
cd C:\PDFValidation
.\.venv\Scripts\Activate.ps1

# Update config.ini paths if the input PDFs/Excels change
# Then run the scripts you need, for example:
python -m utils.FetchData.CM.cm_rent_roll
python -m utils.FetchData.CM.cm_ledger
python -m utils.FetchData.FM.financial_details_result_format
```

If you encounter errors like missing files or missing config sections/keys, re-check `config.ini` and ensure you are executing commands from the project root with the virtual environment activated.
