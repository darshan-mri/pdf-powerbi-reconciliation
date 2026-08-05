Feature: Filter Pane FC FM NOI Analysis
Scenario: Applying filters in the report with default selections
    Given The user logs into Power BI
    And The user selects the workspace
    When The user opens the report
    And The user clicks on the "Filter show/hide" pane
    Then The following filter options should be displayed:
      | Filter Name               |
      | Period                    |
      | Timeframe                 |
      | Budget type               |
      | Group By                  |
      | Group By (level 2)        |
      | Variance Type             |
      | Active Entities           |
      | Basis                     |
      | MRI Financial Format      |
      | Portfolio                 |
      | Ledger code               |
      | Entity Type               |
      | Life Code                 |
      | Property Type             |
      | Property Sub Type         |
      | Class ID                  |
      | Investment flag           |
      | Investment Type           |
      | Location ID               |
      | Client Name               |
      | State ID                  |
      | Suite Type                |
      | Owner                     |
      | Asset Manager             |
      | Department                |
      | Region                    |
      | Acquisition Date          |
      | Disposition Date          |
    And The following filters should be selected by default:
      | Filter Name         | Default Selection        |
      | Period              | Current Period           |
      | Group BY            | Entity                   |
      | Group By (Level 2)  | Entity Type              |
      | Budget type         | STD. Budget              | 
      | Timeframe           | YTD                      |
      | Variance Type       | YOY                      |
      | Active   Entities   | Y                        |
      | Basis               | Accrual                  |
    When The user applies filters from the filter pane
    Then The visuals in the report should be updated
    And The values should be displayed according to the selected filters