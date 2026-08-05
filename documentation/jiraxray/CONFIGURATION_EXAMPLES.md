# Configuration Examples for Multi-Test-Type Import

## SCENARIO 1: Import All Test Types (DEFAULT)

**Goal:** Import all 2,013 tests with full field support

```python
IMPORT_CUCUMBER = True
IMPORT_MANUAL = True
IMPORT_GENERIC = True

SET_ASSIGNEE_TO_CURRENT_USER = True
REMOVE_BACKGROUND_SECTIONS = True
```

**Result:**
- ✓ ~1,200 Cucumber tests
- ✓ ~500 Manual tests
- ✓ ~313 Generic tests
- ✓ All fields populated
- ✓ All in original folders
- ✓ All assigned to current user

**Duration:** 2-3 hours

---

## SCENARIO 2: Import Only Cucumber

**Goal:** Test with Cucumber first, add others later

```python
IMPORT_CUCUMBER = True
IMPORT_MANUAL = False
IMPORT_GENERIC = False

SET_ASSIGNEE_TO_CURRENT_USER = True
REMOVE_BACKGROUND_SECTIONS = True
```

**Result:**
- ✓ ~1,200 Cucumber tests only
- ✓ Manual and Generic skipped
- ✓ Fast import (1 hour)

**When to use:** Testing, verification, phased migration

---

## SCENARIO 3: Import Only Manual Tests

**Goal:** Separate Manual test import

```python
IMPORT_CUCUMBER = False
IMPORT_MANUAL = True
IMPORT_GENERIC = False

SET_ASSIGNEE_TO_CURRENT_USER = True
```

**Result:**
- ✓ ~500 Manual tests only
- ✓ Cucumber and Generic skipped

**When to use:** Phased approach, testing Manual format

---

## SCENARIO 4: Manual + Generic Only

**Goal:** Skip Cucumber, import Manual and Generic

```python
IMPORT_CUCUMBER = False
IMPORT_MANUAL = True
IMPORT_GENERIC = True

SET_ASSIGNEE_TO_CURRENT_USER = True
```

**Result:**
- ✓ ~500 Manual tests
- ✓ ~313 Generic tests
- ✓ ~813 total tests
- ✓ Cucumber skipped

**When to use:** If Cucumber already imported

---

## SCENARIO 5: Import Without Auto-Assigning

**Goal:** Import but don't assign to any user

```python
IMPORT_CUCUMBER = True
IMPORT_MANUAL = True
IMPORT_GENERIC = True

SET_ASSIGNEE_TO_CURRENT_USER = False
```

**Result:**
- ✓ All tests imported
- ✓ NO assignee (blank in Jira)
- ✓ Can assign manually later

**When to use:** Manual assignment control, team distribution

---

## SCENARIO 6: Keep Background Sections

**Goal:** Import Cucumber without removing Background

```python
IMPORT_CUCUMBER = True
IMPORT_MANUAL = True
IMPORT_GENERIC = True

REMOVE_BACKGROUND_SECTIONS = False
```

**Result:**
- ⚠️ Cucumber tests keep Background:
- ✗ Separate Preconditions created
- ⚠️ Not recommended

**When to use:** Only if you want Preconditions

---

## SCENARIO 7: Test Mode - Single Type

**Goal:** Verify script works with minimal tests

```python
IMPORT_CUCUMBER = False
IMPORT_MANUAL = True
IMPORT_GENERIC = False

SET_ASSIGNEE_TO_CURRENT_USER = True
REMOVE_BACKGROUND_SECTIONS = True
```

**Result:**
- ✓ ~500 Manual tests only
- ✓ Quick execution (30 mins)
- ✓ Low risk validation

**When to use:** First-time verification, debugging

---

## SCENARIO 8: Production - All Types

**Goal:** Full production import with monitoring

```python
IMPORT_CUCUMBER = True
IMPORT_MANUAL = True
IMPORT_GENERIC = True

SET_ASSIGNEE_TO_CURRENT_USER = True
REMOVE_BACKGROUND_SECTIONS = True
USE_EXPORT_DATA_FOR_FIELDS = True
```

**Command with logging:**
```powershell
python import_all_test_types.py | Tee-Object -FilePath import_log.txt
```

**After completion:**
```powershell
# Check for failures
Select-String "✗|⚠️" import_log.txt

# View summary
Select-String "SUMMARY" -A 15 import_log.txt
```

**Result:**
- ✓ 1,900-2,000 tests imported
- ✓ Log file saved
- ✓ Production ready

---

## SCENARIO 9: Different Jira Project

**Goal:** Import to staging instead of production

```python
# Change target project
TARGET_PROJECT = "PM"  # Instead of "DT"

# Rest stays same
IMPORT_CUCUMBER = True
IMPORT_MANUAL = True
IMPORT_GENERIC = True

SET_ASSIGNEE_TO_CURRENT_USER = True
```

**Result:**
- ✓ Tests imported to PM project
- ✓ Same structure and fields
- ✓ Staging/testing environment

**When to use:** Staging/UAT before production

---

## SCENARIO 10: Resume Interrupted Import

**Goal:** Continue after interruption

```python
# Run script again - no changes needed
python import_all_test_types.py
```

**Script automatically:**
1. Loads existing mapping file
2. Identifies already-imported tests
3. Skips them (shows "SKIPPED" in console)
4. Continues with remaining tests
5. Updates mapping file

**Result:**
- ✓ No duplicates
- ✓ Resumes from where it stopped
- ✓ Resilient to interruption

---

## SCENARIO 11: Assign to Different User

**Goal:** Assign to specific user instead of current

**Step 1:** Find target user's account ID
```
In Jira: Profile → click name → copy URL ID
Example: 712020:xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

**Step 2:** Edit script
```python
# Find build_test_fields() function
# Replace:
# if current_user_account_id:
#     fields["assignee"] = {"accountId": current_user_account_id}

# With:
fields["assignee"] = {
    "accountId": "712020:different-user-id"  # ← Use their ID
}
```

**Result:**
- ✓ Tests assigned to different user
- ✓ Not current authenticated user

---

## SCENARIO 12: Custom Folder for All

**Goal:** Import all tests to single custom folder

**Edit script - find import loop:**
```python
# Replace this:
if folder_path:
    encoded_folder = quote(folder_path)
    import_url += f"&testRepositoryPath={encoded_folder}"

# With this:
custom_folder = "/Migrated_from_EDP"
encoded_folder = quote(custom_folder)
import_url += f"&testRepositoryPath={encoded_folder}"
```

**Result:**
- ✓ All 2,013 tests in `/Migrated_from_EDP/`
- ✓ Original folder structure ignored
- ✓ Flat structure in DT project

**When to use:** Simple flat organization

---

## SCENARIO 13: Fields Only (No Import)

**Goal:** Update fields on already-imported tests

Use `update_jira_fields.py` instead:

```powershell
python update_jira_fields.py
```

This script:
- Reads xray_export.json for field values
- Reads test_key_mapping.json for old→new keys
- Updates fields only (no import)
- Applies same 7 fields

---

## SCENARIO 14: Dry Run (Test Only)

**Goal:** Verify script logic without importing

**Modify import section:**
```python
# Find this in import loop:
response = requests.post(
    import_url,
    headers=HEADERS,
    files={"file": (filename, content)}
)

# Add this check first:
if os.environ.get('DRY_RUN') == 'true':
    print(f"[DRY RUN] Would POST to {import_url}")
    print(f"[DRY RUN] File: {filename}")
    continue  # Skip actual POST
```

**Run with dry run:**
```powershell
$env:DRY_RUN = 'true'
python import_all_test_types.py
```

**Result:**
- Shows what WOULD be imported
- No actual changes to Jira
- Validates script logic

---

## SCENARIO 15: Phased Migration

**Goal:** Import in phases over time

**Phase 1:** Cucumber (production tests)
```python
IMPORT_CUCUMBER = True
IMPORT_MANUAL = False
IMPORT_GENERIC = False
```

**Phase 2 (next week):** Manual tests
```python
IMPORT_CUCUMBER = False
IMPORT_MANUAL = True
IMPORT_GENERIC = False
```

**Phase 3 (next month):** Generic tests
```python
IMPORT_CUCUMBER = False
IMPORT_MANUAL = False
IMPORT_GENERIC = True
```

**Result:**
- ✓ Staged migration
- ✓ Time for validation between phases
- ✓ Lower risk

---

## CONFIGURATION CHECKLIST

Before running, verify:

- [ ] `xray_export.json` present and valid
- [ ] Target Jira project (DT) created
- [ ] Xray credentials valid
- [ ] Jira credentials valid
- [ ] Adequate time available
- [ ] Choose configuration scenario
- [ ] Backup mapping files if re-importing
- [ ] Have monitoring capability

---

## QUICK CONFIG REFERENCE

```python
# Type configuration
IMPORT_CUCUMBER = True/False
IMPORT_MANUAL = True/False
IMPORT_GENERIC = True/False

# Feature flags
SET_ASSIGNEE_TO_CURRENT_USER = True/False
REMOVE_BACKGROUND_SECTIONS = True/False
USE_EXPORT_DATA_FOR_FIELDS = True/False

# Target
TARGET_PROJECT = "DT"  # Change if needed

# Files
MAPPING_FILE = "test_key_mapping_all_types.json"
EXPORT_FILE = "xray_export.json"
```

---

## RUNNING MULTIPLE PHASES

Example workflow:

```powershell
# Phase 1: Cucumber only
# Edit script, set:
# IMPORT_CUCUMBER = True
# IMPORT_MANUAL = False
# IMPORT_GENERIC = False

python import_all_test_types.py
# Wait for completion...
# Verify results...

# Phase 2: Add Manual
# Edit script, set:
# IMPORT_MANUAL = True

python import_all_test_types.py
# Cucumber skipped automatically (already mapped)
# Manual tests imported...

# Phase 3: Add Generic
# Edit script, set:
# IMPORT_GENERIC = True

python import_all_test_types.py
# Both Cucumber and Manual skipped
# Generic tests imported...
```

---

## MONITORING OUTPUT

Check results after each phase:

```powershell
# Count total tests imported
$mapping = Get-Content test_key_mapping_all_types.json | ConvertFrom-Json
$mapping.Count

# List all mappings
$mapping | ConvertTo-Json

# Find specific test
$mapping.'EDP-11300'
```

---

## RECOMMENDED: Default Production Scenario

```python
# SCENARIO: Safe Full Production Import

IMPORT_CUCUMBER = True          # Yes, all types
IMPORT_MANUAL = True
IMPORT_GENERIC = True

SET_ASSIGNEE_TO_CURRENT_USER = True       # Clear ownership
REMOVE_BACKGROUND_SECTIONS = True         # Best practice
USE_EXPORT_DATA_FOR_FIELDS = True         # Full data

TARGET_PROJECT = "DT"          # Production
```

**Steps:**
1. Set configuration above
2. Run: `python import_all_test_types.py`
3. Monitor for 2-3 hours
4. Verify: check mapping file and Jira
5. Success: All 2,013 tests imported! 🎉

---

**Choose your scenario above and customize as needed!**

