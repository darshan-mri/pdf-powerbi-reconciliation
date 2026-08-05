# Multi-Test-Type Import Guide (Cucumber, Manual, Generic)

## Overview

The new `import_all_test_types.py` script extends the original Cucumber-only import functionality to support **all test types**:

- ✅ **Cucumber** (Feature files with Gherkin scenarios)
- ✅ **Manual** (Test cases with Action/Data/Result steps)
- ✅ **Generic** (Generic test format with Action/Data/Result steps)

**All test types now include the same Jira fields:**
- Description (Atlassian Document Format)
- Labels
- Components
- Priority (mapped to P0-P4)
- Automation Status (customfield_10436)
- Assignee (current user)
- Folder structure preservation

---

## Key Features

### 1. Universal Field Support

All test types are updated with the same fields from the export. This ensures consistent test data across different test types.

**Fields Applied to ALL Types:**
- Description (converted to ADF format)
- Labels (array of labels)
- Components (array of component names)
- Priority (mapped: High→P1, Medium→P2, etc.)
- Automation Status (custom field value)
- Assignee (current authenticated user)
- Folder Path (preserves original location)

### 2. Test Type Configuration

Enable/disable each test type import independently:

```python
IMPORT_CUCUMBER = True   # Import Feature files
IMPORT_MANUAL = True     # Import Manual tests
IMPORT_GENERIC = True    # Import Generic tests
```

### 3. Multiple Import Endpoints

The script uses the correct Xray API endpoint for each type:

| Test Type | API Endpoint | Content Format |
|-----------|-------------|-----------------|
| Cucumber | `/api/v2/import/feature` | Gherkin (.feature file) |
| Manual | `/api/v2/import/test/steps` | CSV (Action, Data, Result) |
| Generic | `/api/v2/import/test/generic` | CSV (Action, Data, Result) |

### 4. Background Section Handling (Cucumber only)

Background steps are automatically removed and inlined into each Scenario to prevent separate Precondition work items from being created in Jira:

```python
REMOVE_BACKGROUND_SECTIONS = True
```

### 5. Folder Structure Preservation

All 133+ unique folders from the original EDP export are preserved during import:

```
Expected Structure Maintained:
/R&A/CustomReports/Thalhimer/Residential/
/BI-Data/UserStoryTests/CBUSCBRE/
/Agora - Action Cards/Query Connector/
[... etc - all folders maintained]
```

### 6. Automatic Assignee Assignment

All imported tests are automatically assigned to the current authenticated user:

```python
SET_ASSIGNEE_TO_CURRENT_USER = True
```

---

## Test Type Details

### Cucumber Tests

**Source:** `gherkin` field from xray_export.json
**Content Type:** Gherkin feature files with scenarios

**Example:**
```gherkin
Feature: User Authentication
  Background:
    Given user is on login page
    
  Scenario: Valid credential login
    When user enters valid username and password
    Then user is authenticated successfully
    And dashboard is displayed
```

**Processing:**
- .feature files extracted from export
- Background sections removed (if configured)
- Folder structure preserved
- Imported via `/import/feature` endpoint
- Fields applied post-import

### Manual Tests

**Source:** `steps` array with structured field data
**Content Type:** Step-by-step instructions

**Export Structure:**
```json
{
  "steps": [
    {
      "action": "Navigate to application URL",
      "data": "URL: https://app.example.com",
      "result": "Application loads successfully"
    },
    {
      "action": "Enter user credentials",
      "data": "Username: testuser, Password: testpass",
      "result": "Login successful"
    }
  ]
}
```

**Converted Format (CSV):**
```csv
Action,Data,Expected Result
"Navigate to application URL","URL: https://app.example.com","Application loads successfully"
"Enter user credentials","Username: testuser, Password: testpass","Login successful"
```

**Processing:**
- Steps extracted and converted to CSV
- Commas in values escaped/replaced with semicolons
- Imported via `/import/test/steps` endpoint
- Fields applied post-import

### Generic Tests

**Source:** `steps` array (same structure as Manual)
**Content Type:** Generic test format

**Same as Manual:**
- Steps extracted from export
- Converted to CSV format
- Imported via `/import/test/generic` endpoint
- Fields applied post-import

---

## Configuration Guide

### Before Running the Import

Edit these configuration options in `import_all_test_types.py`:

```python
# =====================================================
# TEST TYPE CONFIGURATION
# =====================================================

# Control which test types to import
IMPORT_CUCUMBER = True      # Set to False to skip Cucumber tests
IMPORT_MANUAL = True        # Set to False to skip Manual tests
IMPORT_GENERIC = True       # Set to False to skip Generic tests

# =====================================================
# FEATURE FLAGS
# =====================================================

# Assign all imported tests to current user
SET_ASSIGNEE_TO_CURRENT_USER = True

# Remove Background sections from Cucumber tests (recommended)
# This prevents Xray from creating separate Precondition work items
REMOVE_BACKGROUND_SECTIONS = True

# Use data from xray_export.json for field population
USE_EXPORT_DATA_FOR_FIELDS = True

# =====================================================
# API CONFIGURATION (Pre-configured)
# =====================================================

XRAY_CLIENT_ID = "D992F64A744E4BFD8F5F972D3C8AEF9E"
XRAY_CLIENT_SECRET = "4c51ec24c73799498a6d93c8a3430f1566fbaa2939d1de67c1c000b8ad2ff466"

TARGET_PROJECT = "DT"

JIRA_BASE_URL = "https://mripride.atlassian.net"
JIRA_EMAIL = "darshan.singh@mrisoftware.com"
JIRA_API_TOKEN = "ATATT3xFfGF0_eusNbazEg8At25Ez2w4CmykWIDXSV2_Maeoh4pzLGLs7SNEnjfZ..."
```

---

## Usage Instructions

### Step 1: Prepare

Ensure all prerequisites are met:

```powershell
cd C:\PDFValidation\utils\JiraXray

# Verify export file exists
ls xray_export.json

# Verify scripts are present
ls import_all_test_types.py
```

### Step 2: Configure (Optional)

Edit `import_all_test_types.py` if you want custom configuration:

```python
# Example: Only import Manual tests
IMPORT_CUCUMBER = False
IMPORT_MANUAL = True
IMPORT_GENERIC = False
```

### Step 3: Run Import

```powershell
python import_all_test_types.py
```

### Step 4: Monitor Progress

Watch the console output for real-time progress:

```
✓ Xray Authenticated
✓ Jira Authenticated - Will assign tests to: Darshan Singh
✓ Loaded export data from xray_export.json
✓ Loaded existing mapping with 0 entries

Test Type Distribution:
  - Cucumber: 1200
  - Manual: 500
  - Generic: 313

======================================================================
IMPORTING TESTS
======================================================================

[Cucumber ] EDP-11300 - Ensure region is defaulted to null
  → Type: Cucumber | Folder: /R&A/CustomReports/B&F/Financial/Details
  ✓ Created: DT-1500
  ✓ Fields updated

[Manual   ] EDP-15023 - Manual API Validation Test
  → Type: Manual | Folder: /BI-Data/UserStoryTests/CBUSCBRE/
  ✓ Created: DT-1501
  ✓ Fields updated

[Generic  ] EDP-15024 - Generic Test Case
  → Type: Generic | Folder: /Agora - Action Cards/Query Connector/
  ✓ Created: DT-1502
  ✓ Fields updated
```

### Step 5: Verify Results

Check the mapping file and monitor output:

```powershell
# View summary
Get-Content test_key_mapping_all_types.json | ConvertFrom-Json

# Count total mappings
(Get-Content test_key_mapping_all_types.json | ConvertFrom-Json) | Measure-Object

# Check for failures
Select-String "✗" import_log.txt
```

---

## Output & Results

### Mapping File

The script creates `test_key_mapping_all_types.json`:

```json
{
  "EDP-9333": "DT-1326",
  "EDP-10107": "DT-1404",
  "EDP-11300": "DT-1500",
  "EDP-15023": "DT-1501",
  "EDP-15024": "DT-1502",
  ...
}
```

### Summary Report Example

```
======================================================================
IMPORT SUMMARY
======================================================================
Total tests in export: 2013

Test Type Statistics:
  Cucumber: 1200
  Manual: 500
  Generic: 313

Import Results:
  ✓ Successfully imported: 1847
  ⊘ Skipped (already mapped): 166
  ✗ Failed: 5
  Total in mapping: 2013

Mapping saved to: test_key_mapping_all_types.json
```

### Tests in Jira

Each imported test will contain:

- ✓ **Title/Summary** from export
- ✓ **Description** (formatted as Atlassian Document)
- ✓ **Test Type** (Cucumber/Manual/Generic)
- ✓ **Labels** from original test
- ✓ **Components** from original test
- ✓ **Priority** (P0-P4 mapped from original)
- ✓ **Automation Status** (if present in export)
- ✓ **Assignee** = Darshan Singh
- ✓ **Folder** = Original location preserved

---

## Field Mapping Details

### Description Conversion

Plain text descriptions are converted to Atlassian Document Format (ADF):

```python
Input:  "Login with valid credentials and verify access"

Output: {
    "type": "doc",
    "version": 1,
    "content": [{
        "type": "paragraph",
        "content": [{
            "type": "text",
            "text": "Login with valid credentials and verify access"
        }]
    }]
}
```

### Priority Mapping

EDP Jira priorities are mapped to DT Jira priorities:

```
Jira EDP Priority    →    DT Priority
"Highest"            →    "P0"
"High"               →    "P1"
"Medium"             →    "P2"
"Low"                →    "P3"
"Lowest"             →    "P4"
```

### Automation Status

Carries over from export as custom field value:

Examples:
- "Automation Candidate"
- "Cannot Automate"
- "Ready to Automate"
- "Automated"

---

## Common Issues & Solutions

### Issue: "No gherkin content found"

**Cause:** Cucumber test in export has no gherkin content
**Solution:** 
1. Verify export file is complete
2. Check if test actually has content in EDP
3. Re-export if necessary

### Issue: "No steps found for manual test"

**Cause:** Manual or Generic test missing steps in export
**Solution:**
1. Verify export includes steps data
2. Check if test has steps in original EDP instance

### Issue: Import failed with 400 error

**Cause:** Invalid field value or malformed request
**Solution:**
1. Check console error message for details
2. Usually field-specific (description format, etc.)

### Issue: Tests created but fields not updated

**Cause:** Jira API authentication failed
**Solution:**
1. Verify JIRA_API_TOKEN is valid and not expired
2. Confirm user has permission to edit issues

### Issue: "Could not retrieve user info"

**Cause:** Jira authentication failed at startup
**Solution:**
1. Verify email and API token are correct
2. Check if account has API access enabled

### Issue: Tests merged (multiple old keys → same new key)

**Cause:** Duplicate scenario names across files
**Solution:**
1. Expected if duplicates exist in original export
2. Update field mapping for duplicates
3. Consider re-naming tests to ensure uniqueness

---

## Advanced Topics

### Dry Run Mode

To test without actually importing:

```python
# In the import section, comment out:
# response = requests.post(import_url, ...)

# Replace with:
print(f"[DRY RUN] Would import: {filename}")
continue
```

### Resume Interrupted Import

The script automatically resumes:

```python
# Load existing mapping
if os.path.exists(MAPPING_FILE):
    mapping = json.load(f)

# Skip already-imported tests
if old_key in mapping:
    skipped_count += 1
    continue
```

**To resume:** Simply run the script again

### Custom Folder Assignment

To import all tests to a custom folder:

```python
# Replace folder path logic with:
custom_folder = "/Migrated_from_EDP"
encoded_folder = quote(custom_folder)
import_url += f"&testRepositoryPath={encoded_folder}"
```

### Different Assignee

To assign to a different user:

```python
# Instead of current user, use:
fields["assignee"] = {
    "accountId": "712020:different-user-id-here"
}
```

Find account ID in Jira UI → Profile → URL

---

## Performance Expectations

| Metric | Value |
|--------|-------|
| Import Speed | ~1-2 tests/second |
| Total Time (2013 tests) | 2-3 hours |
| Xray API Calls | ~3,000-4,000 |
| Jira API Calls | ~2,000 (for field updates) |
| Network Bandwidth | ~50-100 MB |
| Memory Usage | ~200-300 MB |

---

## Support

For additional help:

1. **Quick Reference:** See `QUICK_REFERENCE_IMPORT.md`
2. **Configuration Examples:** See `CONFIGURATION_EXAMPLES.md`
3. **Summary:** See `IMPORT_SUMMARY.md`
4. **Console Output:** Check detailed error messages in import console

---

## Success Checklist

After import completes successfully:

- [ ] All 2,013 tests appear in DT project
- [ ] Folder structure is preserved
- [ ] Fields are populated (Description, Labels, etc.)
- [ ] Tests are assigned to current user
- [ ] Mapping file created with all keys
- [ ] Test types variety (Cucumber, Manual, Generic)
- [ ] No duplicate issues created
- [ ] Import completed without stopping

---

**READY FOR IMPORT!** 🚀

