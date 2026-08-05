Feature: Commercial Occupancy

  Scenario: Handle NaN/Null/Nil/Blank values in Power BI visuals
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then NaN/Null//Blank values should not be displayed in any of the visuals