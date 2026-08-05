Feature: Visual rendering and negative value formatting in Power BI

  Scenario: User views a report with correctly rendered visuals and formatted negative values
    Given the user logs into Power BI
    And the user selects a workspace
    When the user opens a report
    Then the user should see all visuals without any visual breakage
    And if any visual contains negative values, those values should be displayed within parentheses (e.g., -10 should appear as (10))