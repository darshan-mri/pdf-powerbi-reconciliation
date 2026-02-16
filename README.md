# PDFValidation

Tools for extracting data from property management PDFs (aged delinquencies, ledgers, rent rolls, income statements) and validating it against Excel reports.

## Getting Started

### 1. Prerequisites

- Windows machine (paths and sample files in this repo are Windows-oriented)
- **Python 3.11** recommended (Python 3.10+ supported, but 3.11 is most stable)
- Git installed (to clone the repository)
- **PyCharm IDE** recommended for best compatibility (VS Code also supported)

Check Python:

```powershell
python --version
# Recommended: Python 3.11.x
```

> **Note:** While Python 3.10+ is supported, we strongly recommend **Python 3.11** for the best compatibility with all dependencies (pandas, openpyxl, pdfplumber, etc.). For the IDE, **PyCharm** (Community or Professional) is recommended as it provides the best Python development experience with excellent debugging, package management, and virtual environment handling. If you experience any issues, please see the [Troubleshooting](#troubleshooting) section.

### 2. Clone the repository

```powershell
cd C:\
git clone https://github.com/darshan-mri/PDFValidation.git
cd PDFValidation
```


### 3. Create and activate a virtual environment

#### Option A: Using PyCharm (Recommended - Easiest)

**PyCharm will create and manage the virtual environment for you automatically:**

1. Open the project in PyCharm:
   - `File` → `Open` → Select `C:\PDFValidation`

2. PyCharm will detect that there's no virtual environment and show a notification:
   - Click **"Create Virtual Environment"** or **"Configure Python Interpreter"**
   - Select **Python 3.11** as the base interpreter
   - PyCharm will create `.venv` automatically

3. Alternatively, manually configure it:
   - Go to `File` → `Settings` → `Project: PDFValidation` → `Python Interpreter`
   - Click the gear icon ⚙️ → `Add` → `Virtualenv Environment`
   - Select `New` and choose Python 3.11 as the base interpreter
   - Location should be `C:\PDFValidation\.venv`
   - Click `OK`

4. **That's it!** PyCharm will:
   - ✅ Automatically activate the venv in its built-in terminal
   - ✅ Use the venv for running scripts
   - ✅ Show you which packages are installed
   - ✅ No need to run `.\.venv\Scripts\Activate.ps1` manually

> **Note:** PyCharm handles all virtual environment activation automatically. You'll see `(.venv)` in PyCharm's terminal, and all scripts run through PyCharm will use the correct environment.

#### Option B: Manual Setup (Command Line / VS Code Users)

If you're not using PyCharm, create the virtual environment manually from the project root (`C:\PDFValidation`):

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

You should see `(.venv)` in your PowerShell prompt.

### 4. Install dependencies

#### For PyCharm Users:

PyCharm will prompt you to install requirements automatically when it detects `requirements.txt`. You can:

1. **Click the notification banner** that says "Install requirements" when you open the project, or
2. **Use PyCharm's terminal** (which has venv auto-activated):
   ```powershell
   pip install --upgrade pip
   pip install -r requirements.txt
   ```
3. **Or use the Package Manager UI:**
   - Go to `File` → `Settings` → `Project: PDFValidation` → `Python Interpreter`
   - Click `+` to add packages individually, or
   - PyCharm may show a banner to install from `requirements.txt`

#### For Command Line / VS Code Users:

With the virtual environment active, install the required Python packages:

```powershell
pip install --upgrade pip
pip install -r requirements.txt
```

#### Installed Libraries:

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

#### For PyCharm Users:

Simply right-click on any Python script (e.g., `utils/FetchData/CM/cm_rent_roll.py`) and select **"Run"**. PyCharm automatically uses the correct virtual environment - no activation needed!

Or use PyCharm's terminal (venv is auto-activated):
```powershell
python -m utils.FetchData.CM.cm_rent_roll
```

#### For Command Line / VS Code Users:

Always activate the virtual environment first:

```powershell
cd C:\PDFValidation
.\.venv\Scripts\Activate.ps1
```

#### Example: CM Rent Roll Extraction

```powershell
python -m utils.FetchData.CM.cm_rent_roll
```

This script:

- Reads the CM rent roll PDF configured under `[CM.ROLL] / PDF`.
- Parses totals and other metrics by building.
- Writes an Excel file to the path configured as `[CM.ROLL] / ExtractedBuilding`.

If you encounter errors like missing files or missing config sections/keys, re-check `config.ini` and ensure you are executing commands from the project root with the virtual environment activated.

## Troubleshooting

### Python Version Issues

If you encounter issues with package installations or runtime errors, we recommend using **Python 3.11** specifically:

#### Symptoms of version-related issues:
- Package installation failures
- Import errors
- Compatibility warnings from libraries like `pandas`, `openpyxl`, or `pdfplumber`
- Unexpected runtime errors

#### Solution: Use Python 3.11

1. **Download Python 3.11** from the official Python website:
   - Visit: https://www.python.org/downloads/
   - Download Python 3.11.x (latest patch version)
   - During installation, check "Add Python to PATH"

2. **Verify Python 3.11 installation:**
   ```powershell
   python --version
   # Should show: Python 3.11.x
   ```

3. **If multiple Python versions are installed**, use the Python Launcher:
   ```powershell
   py -3.11 --version
   ```

4. **Recreate your virtual environment with Python 3.11:**
   ```powershell
   # Remove old virtual environment
   Remove-Item -Recurse -Force .venv
   
   # Create new venv with Python 3.11
   py -3.11 -m venv .venv
   
   # Or if Python 3.11 is your default:
   python -m venv .venv
   
   # Activate the new environment
   .\.venv\Scripts\Activate.ps1
   
   # Upgrade pip and install dependencies
   pip install --upgrade pip
   pip install -r requirements.txt
   ```

5. **Configure your IDE to use Python 3.11:**
   
   **For PyCharm (Recommended):**
   - Go to `File` → `Settings` → `Project: PDFValidation` → `Python Interpreter`
   - Click the gear icon → `Add`
   - Select `Existing Environment` and browse to `.venv\Scripts\python.exe`
   - Or create a new virtualenv using Python 3.11 as the base interpreter
   - **Benefits of PyCharm:**
     - Automatic virtual environment detection and activation
     - Built-in package management with visual interface
     - Superior code completion and type checking
     - Integrated debugging with breakpoints
     - Better handling of relative imports and project structure
   
   **For VS Code:**
   - Press `Ctrl+Shift+P` → Type "Python: Select Interpreter"
   - Choose `.venv\Scripts\python.exe` (should show Python 3.11.x)
   - If not visible, click "Enter interpreter path" and browse to it

### IDE Recommendation

We strongly recommend using **PyCharm** (Community Edition is free) for this project because:
- **Better Python integration**: PyCharm is purpose-built for Python development
- **Smart virtual environment handling**: Automatically detects and activates venvs
- **Superior debugging**: Set breakpoints, inspect variables, step through code with ease
- **Package management**: Visual interface for installing/updating packages
- **Code intelligence**: Better code completion, refactoring, and error detection
- **Project structure awareness**: Handles relative imports and module paths correctly

**Download PyCharm:** https://www.jetbrains.com/pycharm/download/

### Other Common Issues

- **"Module not found" errors**: Ensure virtual environment is activated and dependencies are installed
- **PDF parsing errors**: Verify PDF files exist at paths specified in `config.ini`
- **Excel file errors**: Check that Excel files are not open in Excel while running scripts
- **Permission errors**: Run PowerShell as Administrator if needed

