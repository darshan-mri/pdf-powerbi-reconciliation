Feature: Reseidential Vacancy Analysis

  Scenario: User views table visual alignment
    Given the user is logged into Power BI
    And the user selects a workspace
    When the user opens a report
    And navigates to a page with a table visual
    Then the column names in the table should be left-aligned
    And the values in the table should be right-aligned