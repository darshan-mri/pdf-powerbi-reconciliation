Feature: Financial Details + Regional Format and Currency Display

  Scenario: User sees dates and amounts in local regional format and currency
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    Then User should see the As of Date, Updated date, Period, and Filter Dates in the local regional format
    And User should see all the amounts displayed in local regional currency format