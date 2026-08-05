Feature: Commercial Lease Gantt

  Scenario: Align table columns and values in Power BI
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And navigates to the page with a table visual
    Then the column names in the table should be left-aligned
    And the values in the table should be right-aligned