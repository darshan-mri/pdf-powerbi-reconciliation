Feature: Commercial AR Patterns

  Scenario: Ensure no NaN/Null/Nil values in report visuals
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the report
    Then NaN/Null/Nil values should not be displayed in any of the visuals