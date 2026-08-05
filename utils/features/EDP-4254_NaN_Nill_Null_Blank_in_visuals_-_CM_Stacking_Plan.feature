Feature: Commercial Stacking Plan

  Scenario: Handling NaN/Null/Nill values in visuals
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then NaN/Null/Nill values should not be displayed in any of the visuals