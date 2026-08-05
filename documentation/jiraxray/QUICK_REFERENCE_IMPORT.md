# Multi-Test-Type Import - Quick Reference

## ONE-COMMAND IMPORT

```powershell
cd C:\PDFValidation\utils\JiraXray
python import_all_test_types.py
```

---

## DEFAULT: IMPORT ALL TEST TYPES

```python
IMPORT_CUCUMBER = True    # ~1,200 tests
IMPORT_MANUAL = True      # ~500 tests
IMPORT_GENERIC = True     # ~313 tests
```

**Will Import:**
- ✅ ~2,013 total tests
- ✅ All with same 7 fields
- ✅ Organized in 133+ folders
- ✅ Assigned to: Darshan Singh

---

## COMMON CONFIGURATIONS

### 1. Cucumber Only
```python
IMPORT_CUCUMBER = True
IMPORT_MANUAL = False
IMPORT_GENERIC = False
```
Result: ~1,200 Cucumber tests

### 2. Manual Only
```python
IMPORT_CUCUMBER = False
IMPORT_MANUAL = True
IMPORT_GENERIC = False
```
Result: ~500 Manual tests

### 3. Manual + Generic (Skip Cucumber)
```python
IMPORT_CUCUMBER = False
IMPORT_MANUAL = True
IMPORT_GENERIC = True
```
Result: ~813 Manual + Generic tests

### 4. Without Assignee
```python
SET_ASSIGNEE_TO_CURRENT_USER = False
```
Result: Tests imported, NO assignee set

### 5. Keep Background (Not Recommended)
```python
REMOVE_BACKGROUND_SECTIONS = False
```
Result: Separate Preconditions created

---

## FIELDS APPLIED TO ALL TYPES

| Field | Applied To |
|-------|-----------|
| **Description** | Cucumber, Manual, Generic |
| **Labels** | Cucumber, Manual, Generic |
| **Components** | Cucumber, Manual, Generic |
| **Priority** (P0-P4) | Cucumber, Manual, Generic |
| **Automation Status** | Cucumber, Manual, Generic |
| **Assignee** | Cucumber, Manual, Generic |
| **Folder** | Cucumber, Manual, Generic |

---

## IMPORT FORMATS

### Cucumber Input
```gherkin
Feature: Login
  Scenario: Valid user
    Given user at login page
    When user enters credentials
    Then login succeeds
```
**Output:** DT-1500 (Cucumber test type)

### Manual Input
```json
{
  "steps": [
    {
      "action": "Click login",
      "data": "User: admin",
      "result": "Form displayed"
    }
  ]
}
```
**Output:** DT-1501 (Manual test type)

### Generic Input
Same as Manual, output as Generic test type

---

## CONSOLE OUTPUT FORMAT

```
[Cucumber ] EDP-11300 - Test description...
  → Type: Cucumber | Folder: /R&A/CustomReports/...
  ✓ Created: DT-1500
  ✓ Fields updated

[Manual   ] EDP-15023 - Manual test...
  → Type: Manual | Folder: /BI-Data/UserStoryTests/...
  ✓ Created: DT-1501
  ✓ Fields updated

[Generic  ] EDP-15024 - Generic description...
  → Type: Generic | Folder: /
  ✓ Created: DT-1502
  ✓ Fields updated
```

---

## EXPECTED RESULTS

### In Jira DT Project

```
Test Repository/
├── / (root - 771 tests)
├── /AIG/ (43 tests)
├── /Agora - Action Cards/ (99 tests)
├── /BI-Data/ (343 tests)
└── /R&A/ (1,000+ tests)
    ├── /CustomReports/Thalhimer/
    ├── /CustomReports/B&F/
    ├── /Affordable Housing/
    └── ...
```

### Each Test Contains

- ✓ Summary
- ✓ Description (formatted)
- ✓ Type (Cucumber/Manual/Generic)
- ✓ Labels
- ✓ Components
- ✓ Priority (P0-P4)
- ✓ Automation Status
- ✓ Assignee = Darshan Singh
- ✓ Folder = Original preserved

---

## SUMMARY OUTPUT

```
Total tests in export: 2013

Test Type Statistics:
  Cucumber: 1200
  Manual: 500
  Generic: 313

Import Results:
  ✓ Successfully imported: 1847
  ⊘ Skipped: 166
  ✗ Failed: 5
  Total in mapping: 2013
```

---

## TROUBLESHOOTING

### No gherkin content error
→ Check export file, might be incomplete

### No steps found error
→ Verify export data includes steps for that test

### 400 error on import
→ Check console error message, usually field-specific

### Tests created but fields not updated
→ Verify Jira API token is valid

### "Could not retrieve user info"  
→ Verify Jira credentials in config

---

## MAPPING FILE

**Created:** `test_key_mapping_all_types.json`

```json
{
  "EDP-9333": "DT-1326",
  "EDP-11300": "DT-1500",
  "EDP-15023": "DT-1501",
  "EDP-15024": "DT-1502",
  ...2013 total entries...
}
```

---

## TIMING

| Activity | Time |
|----------|------|
| Authenticate | <1 min |
| Load export | 1 min |
| Import 2013 tests | 2-3 hours |
| **TOTAL** | **2-3 hours** |

---

## BEFORE YOU START

✅ Verify:
- [ ] `xray_export.json` exists
- [ ] DT project exists in Jira
- [ ] Xray credentials valid
- [ ] Jira credentials valid
- [ ] 2-3 hours available (don't interrupt)

---

## GO!

```powershell
cd C:\PDFValidation\utils\JiraXray
python import_all_test_types.py

# Expected: 1,900-2,000 tests successfully imported ✅
```

---

## DOCUMENTATION

- **Full Guide:** `MULTI_TEST_TYPE_IMPORT_GUIDE.md`
- **Configuration:** `CONFIGURATION_EXAMPLES.md`  
- **Summary:** `IMPORT_SUMMARY.md`
- **Script:** `import_all_test_types.py`

