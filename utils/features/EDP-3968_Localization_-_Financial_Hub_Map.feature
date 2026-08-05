Feature: Financial Hub Map + Date and Currency Formatting

  Scenario: Ensure dates and amounts are displayed in local regional format
    Given User logs into PowerBI
    And User Opens Financial Hub Map report from the workspace
    Then User should see the As of Date, Updated Date, and Filter Dates in the local regional format
    And User should see all the amounts displayed in local regional currency format