Feature: Financial NOI Analysis Report

  Scenario: Verify Operating Exps Keycard details in Financial NOI Analysis report
    Given User logs into PowerBI
    When User opens the Financial NOI Analysis report from the workspace
    Then User should see the Operating Exps Keycard with the following details displayed:
      | Operating Exps Amount   |
      | Operating Exps Variance | 
      | Variance Percentage     |