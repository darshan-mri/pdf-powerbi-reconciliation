Feature: Financial Details + No Invalid Values in Visuals

  Scenario: User should not see any NaN, NIL, NULL, or Blank values in the visuals
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    Then User should not see any NaN, NIL, NULL, or Blank values in the visuals