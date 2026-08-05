Feature: Financial NOI Analysis Report

  Scenario: Verify Revenue Keycard details in Financial NOI Analysis report
    Given User logs into PowerBI
    When User opens the Financial NOI Analysis report from the workspace
    Then User should see the Revenue Keycard with the following details displayed:
      | Revenue Amount      | 
      | Revenue Variance    | 
      | Variance Percentage |