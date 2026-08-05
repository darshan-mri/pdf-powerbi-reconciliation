Feature: Residential Vacancy Analysis

  Scenario: User accesses the User guide for a report

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on the "User guide" link
    Then the User guide for the corresponding report should be loaded