Scenario: Verify visuals in B&F Commercial Rent Roll report load successfully
  Given the user logs into Power BI
  And the user selects the appropriate Workspace
  When the user opens the "B&F Commercial Rent Roll" report
  Then the following visuals should load successfully without any breakage:
    | Visual Group            | Visual Name                        |
    | General Info            | As of Date                         |
    | General Info            | Updated Date                       |
    | Unit Summary            | Total Units                        |
    | Unit Summary            | Occupied Units                     |
    | Unit Summary            | Reserved Units                     |
    | Unit Summary            | Vacant Units                       |
    | Rent Roll - Actuals     | Annual Rent Bar Graph              |
    | Rent Roll - Budget      | Annual Rent Bar Graph              |
    | Tables                  | Rent Roll Table                    |
    | Totals                  | Budget Totals                      |
    | Keycards                | Total sq.Ft                        |
    | Keycards                | Monthly Rent                       |
    | Keycards                | Annual Rent                        |
    | Keycards                | Annual Rent PSF                    |
    | Keycards                | Monthly Cost Recovery              |
    | Keycards                | Monthly Other Income               |