Feature: Residential Occupancy - Focus Mode for Average Monthly Rent Chart

  Scenario: User interacts with the Average Monthly Rent chart in Focus Mode
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the Average Monthly Rent chart
    And clicks on the Focus Mode button/icon for the chart
    Then The visual should expand to fill the screen
    And other page elements should be hidden
    And the user should see the Back to report button
    When the user clicks on the Back to report button
    Then It should navigate back to the page