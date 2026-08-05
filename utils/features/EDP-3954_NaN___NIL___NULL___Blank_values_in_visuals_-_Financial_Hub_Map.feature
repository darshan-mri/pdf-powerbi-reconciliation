Feature: Financial Hub Map + No Null/Blank/Invalid Values in Visuals

  Scenario: User does not see any NaN / NIL / NULL / Blank values in the visuals
    Given User logs into PowerBI
    And User opens Financial Hub Map report from the workspace
    Then User should not see any NaN / NIL / NULL / Blank values in the visuals