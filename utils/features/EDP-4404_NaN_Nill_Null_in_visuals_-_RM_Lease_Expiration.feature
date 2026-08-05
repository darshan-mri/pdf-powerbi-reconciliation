Feature: Residential Lease Expiration - Handling Null/NaN/Blank Values in Visuals

  Scenario: User opens the report and ensures no NaN/Null/Blank values are displayed in any visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then NaN/Null/Null/Blank values should not be displayed in any of the visuals