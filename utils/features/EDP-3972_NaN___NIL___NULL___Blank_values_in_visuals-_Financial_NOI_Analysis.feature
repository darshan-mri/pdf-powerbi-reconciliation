Feature: Financial NOI Analysis Report

  Scenario: Verify no NaN / NIL / NULL / Blank values in Financial NOI Analysis report visuals
    Given User logs into PowerBI
    When User opens the Financial NOI Analysis report from the workspace
    Then User should not see any NaN / NIL / NULL / Blank values in the visuals