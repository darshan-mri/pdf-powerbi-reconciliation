Feature: Residential Vacancy Analysis

  Scenario: User restricts data based on selected period

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And selects any of the periods:
      | Periods  |
      | Current  |
      | 30 Days  |
      | 60 Days  |
      | 90 Days  |
      | >90 Days |
    Then the data should be restricted based on the period selected