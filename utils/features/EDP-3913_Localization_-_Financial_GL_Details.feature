Feature: Financial GL Details Report Regional Formatting Feature

  Scenario: Ensure dates and amounts are displayed in the local regional format
    Given User logs into PowerBI
    And User opens Financial GL Details report from the workspace
    Then User should see the Updated date and Filter dates in the local regional format
    And User should see all the amounts displayed in local regional currency format