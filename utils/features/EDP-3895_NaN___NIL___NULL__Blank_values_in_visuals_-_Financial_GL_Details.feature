Feature: Financial GL Details Report Data Integrity Feature

  Scenario: Ensure no NaN / NIL / NULL / Blank values are displayed in the visuals
    Given User logs into PowerBI
    And User opens Financial GL Details report from the workspace
    Then User should not see any NaN / NIL / NULL / Blank values in the visuals