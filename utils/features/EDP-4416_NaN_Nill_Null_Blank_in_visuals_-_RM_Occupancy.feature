Feature: Residential Occupancy - No Null or Blank Values in Visuals

  Scenario: Ensure no NaN/Null/Null/Blank values are displayed in any visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then NaN/Null/Null/Blank values should not be displayed in any of the visuals