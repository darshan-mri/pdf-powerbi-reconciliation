Feature: Invalid Values FC FM NOI Analysis
Scenario: User views the Financial NOI analysis report without any invalid values
    Given User logs into Power BI
    When User opens the Financial NOI analysis report from the workspace
    Then User should not see any NaN, NIL, NULL, or Blank values in the visuals
    And All data points in the visuals should be valid and properly displayed