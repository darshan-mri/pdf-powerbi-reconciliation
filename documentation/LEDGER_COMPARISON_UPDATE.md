# Ledger Comparison - Multi-Sheet Update Summary

## What Was Changed

### Problem Identified
The original `compare_excels()` function only compared the "LeaseTotals" sheet from both the extracted data and report Excel files. It completely ignored the "BuildingTotals" (or "BldgTotals") sheets that exist in both files.

### Solution Implemented

#### 1. Updated `compare_excels()` Function (cm_ledger.py)

**New Features:**
- ✅ Now compares **both** LeaseTotals and BuildingTotals sheets
- ✅ Creates **separate comparison sheets** for each:
  - `LeaseComparison` - Compares lease-level data (merges on: building + lease)
  - `BuildingComparison` - Compares building-level data (merges on: building only)
- ✅ Automatically detects sheet names (flexible matching for "Bldg"/"Building")
- ✅ Better error handling and informative console output

**New Helper Function:**
- `_compare_dataframes()` - Refactored comparison logic into a reusable function
  - Takes merge keys as parameter (allows different granularity)
  - Returns comparison DataFrame with match columns

#### 2. Updated Output Structure

**Before:**
```
ledger_comparison_results.xlsx
  └── Sheet1 (only lease comparisons)
```

**After:**
```
ledger_comparison_results.xlsx
  ├── LeaseComparison (lease-level data)
  │   ├── building
  │   ├── lease
  │   ├── charges_extracted
  │   ├── charges_report
  │   ├── cash_receipts_extracted
  │   ├── cash_receipts_report
  │   ├── charges_match
  │   ├── cash_match
  │   └── Overall_Match
  │
  └── BuildingComparison (building-level totals)
      ├── building
      ├── charges_extracted
      ├── charges_report
      ├── cash_receipts_extracted
      ├── cash_receipts_report
      ├── charges_match
      ├── cash_match
      └── Overall_Match
```

#### 3. Updated format_ledger_comparison.py

- Added `sheet_name` parameter to specify which comparison sheet to format
- Auto-detects available sheets and selects appropriately
- Defaults to "LeaseComparison" sheet

## How to Use

### Running Full Extraction and Comparison
```python
python utils/FetchData/CM/cm_ledger.py
```

This will:
1. Extract data from PDF → `ledgers_totals_with_ids.xlsx` (2 sheets)
2. Compare with report → `ledger_comparison_results.xlsx` (2 comparison sheets)

### Formatting Results
```python
from utils.FetchData.CM.format_ledger_comparison import format_ledger_comparison

# Format lease comparison (default)
format_ledger_comparison()

# Or specify which sheet to format
format_ledger_comparison(sheet_name="BuildingComparison")
```

## Console Output Example

When running the comparison, you'll now see:
```
📊 Extracted sheets: ['LeaseTotals', 'BuildingTotals']
📊 Report sheets: ['LeaseTotals', 'BldgTotals']
✅ Lease comparison completed (150 records)
✅ Building comparison completed (25 records)
📁 All comparisons saved -> ledger_comparison_results.xlsx
```

## Benefits

1. **Complete Validation** - Now validates both lease and building-level totals
2. **Separate Analysis** - Can analyze mismatches at different granularities
3. **Flexible** - Automatically adapts to different sheet naming conventions
4. **Maintainable** - Refactored code is cleaner and easier to extend

## Files Modified

- `utils/FetchData/CM/cm_ledger.py` - Main comparison logic
- `utils/FetchData/CM/format_ledger_comparison.py` - Formatting script
