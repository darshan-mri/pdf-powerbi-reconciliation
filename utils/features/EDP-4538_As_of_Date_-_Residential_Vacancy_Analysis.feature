Feature: Residential Vacancy Analysis

  Scenario: User views the current date in the report

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the "as of date" displayed should be the current date
    And it should follow the format mm/dd/yyyy