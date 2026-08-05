Feature: Commercial Top N Dashboard

  Scenario: Verify table alignment in the report
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And the user navigates to a page with a table visual
    Then the column names in the table should be left-aligned
    And the values in the table should be right-aligned