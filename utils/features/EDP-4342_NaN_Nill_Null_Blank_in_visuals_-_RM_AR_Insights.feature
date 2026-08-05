Feature: Residential AR Insights

  Scenario: User views the report without NaN/Null/Null values in visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then NaN/Null/Null/Blank values should not be displayed in any of the visuals