Feature: Residential Vacancy Analysis

  Scenario: User views report without NaN/Null/Nil values

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then NaN/Null/Nil/Blank values should not be displayed in any of the visuals