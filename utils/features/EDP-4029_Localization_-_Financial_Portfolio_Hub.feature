Feature: Display of Dates and Amounts in Local Regional Format in the Financial Portfolio Hub Report

  Scenario: User verifies dates and amounts in local regional format
    Given User logs into PowerBI
    And User opens Financial Portfolio Hub report from the workspace
    Then User should see the "As of Date", "Updated Date", and "Filter Dates" in the local regional format
    And User should see all the amounts displayed in the local regional currency format