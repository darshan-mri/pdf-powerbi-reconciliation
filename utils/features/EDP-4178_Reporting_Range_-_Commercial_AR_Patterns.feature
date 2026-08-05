Feature: Commercial AR Patterns

  Scenario: Update report data based on selected reporting range
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the report
    Then the reporting range should selected as 'Current Month' by default
    And the user should be able to select the date <Reporting Range>
    When the user selects the <Reporting Range>
    Then the billings and payments graph, billings and payments table, Tenant AR pattern table, and Open receivable details table data should be updated according to the selected <Reporting Range>

    | Reporting Range     |
    | Current Month       |
    | Trailing 3 months   |
    | Trailing 6 months   |
    | Trailing 12 months  |
    | YTD                 |
    | QTD                 |