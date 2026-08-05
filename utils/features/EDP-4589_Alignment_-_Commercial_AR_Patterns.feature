Feature: Commercial AR Patterns

  Scenario: Ensure proper alignment of table columns and values
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the report
    And the user navigates to a page with a table visual
    Then the column names in the table should be left-aligned
    And the values in the table should be right-aligned