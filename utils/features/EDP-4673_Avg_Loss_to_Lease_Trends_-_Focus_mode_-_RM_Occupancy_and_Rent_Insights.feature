Feature: Residentials Occupancy and Rent Insights

  Scenario: Interacting with the Avg Loss to Lease Trends chart in focus mode
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User navigates to the Avg Loss to Lease Trends chart
    And User clicks on the Focus Mode button/icon for the chart
    Then The visual should expand to fill the screen
    And Other page elements should be hidden
    And The user should see the Back to report button
    When The user clicks on the Back to report button
    Then It should navigate back to the page