Feature: Financial NOI Analysis Report

  Scenario: Verify NOI MTD Keycard details in Financial NOI Analysis report
    Given User logs into PowerBI
    When User opens the Financial NOI Analysis report from the workspace
    Then User should see the NOI MTD Keycard with the following details displayed:
      | NOI Amount          | 
      | NOI Variance        | 
      | Variance Percentage |
    And if NOI Variance or NOI Budget value is negative, the Variance Percentage should display with a negative sign