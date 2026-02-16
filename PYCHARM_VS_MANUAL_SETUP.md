# PyCharm vs Manual Setup Quick Reference

## TL;DR: Do I need to run `python -m venv .venv` and `.\.venv\Scripts\Activate.ps1` in PyCharm?

**NO!** If you're using PyCharm, you don't need to manually create or activate the virtual environment.

## What PyCharm Does Automatically

### 1. Virtual Environment Creation ✅
- PyCharm creates `.venv` for you when you configure the Python interpreter
- No need to run: `python -m venv .venv`

### 2. Virtual Environment Activation ✅
- PyCharm's built-in terminal automatically activates the venv
- PyCharm's run configurations automatically use the venv
- No need to run: `.\.venv\Scripts\Activate.ps1`

### 3. Package Installation ✅
- PyCharm detects `requirements.txt` and prompts you to install packages
- Visual package manager available in Settings → Python Interpreter
- Or just use PyCharm's terminal: `pip install -r requirements.txt`

## PyCharm Setup Steps (Only 3 Steps!)

1. **Open Project**
   - `File` → `Open` → Select `C:\PDFValidation`

2. **Configure Python 3.11 Interpreter**
   - `File` → `Settings` → `Project: PDFValidation` → `Python Interpreter`
   - Click gear icon → `Add` → `Virtualenv Environment` → `New`
   - Select Python 3.11 as base interpreter
   - Click `OK`

3. **Install Requirements**
   - Click the "Install requirements" notification banner, OR
   - In PyCharm's terminal: `pip install -r requirements.txt`

**That's it!** You're ready to run scripts.

## Manual Setup Steps (5 Steps - More Complex)

Only if you're NOT using PyCharm (e.g., using VS Code or command line):

1. Open PowerShell
2. Navigate to project: `cd C:\PDFValidation`
3. Create venv: `python -m venv .venv`
4. Activate venv: `.\.venv\Scripts\Activate.ps1`
5. Install packages: `pip install -r requirements.txt`

**And you must activate the venv every time you open a new terminal!**

## Running Scripts

### In PyCharm:
- Right-click any `.py` file → `Run`
- Or use terminal (venv auto-activated): `python -m utils.FetchData.CM.cm_rent_roll`

### Manual/VS Code:
- Must activate venv first: `.\.venv\Scripts\Activate.ps1`
- Then run: `python -m utils.FetchData.CM.cm_rent_roll`

## Why PyCharm is Better

| Feature | PyCharm | Manual/VS Code |
|---------|---------|----------------|
| Auto-creates venv | ✅ Yes | ❌ Manual |
| Auto-activates venv | ✅ Yes | ❌ Must activate every time |
| Visual package manager | ✅ Yes | ❌ Command line only |
| Debugging with breakpoints | ✅ Excellent | ⚠️ Limited/requires setup |
| Code completion | ✅ Superior | ⚠️ Basic |
| Import detection | ✅ Automatic | ⚠️ Often fails |

## Bottom Line

**Using PyCharm?** Skip all the `venv` and `Activate.ps1` commands. PyCharm handles everything!

**Not using PyCharm?** Follow the manual setup steps and remember to activate the venv every time.
