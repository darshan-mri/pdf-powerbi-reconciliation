Feature: Table Alignment

  Scenario: User views alignment in a table visual

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And navigates to a page with a table visual
    Then the column names in the table should be left-aligned
    And the values in the table should be right-aligned