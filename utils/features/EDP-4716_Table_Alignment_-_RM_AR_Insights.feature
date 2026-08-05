Feature: Residential AR Insights

  Scenario: User views alignment in a table visual
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User navigates to a page with a table visual
    Then The column names in the table should be left-aligned
    And The values in the table should be right-aligned