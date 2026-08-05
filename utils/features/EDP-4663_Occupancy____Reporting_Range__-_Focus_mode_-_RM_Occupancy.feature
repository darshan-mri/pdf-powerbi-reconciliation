Feature: Residential Occupancy - Occupancy % - Focus Mode for Chart

  Scenario: User interacts with the Occupancy % chart in Focus Mode
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And the user navigates to the Occupancy % chart
    And clicks on the Focus Mode button/icon for the chart
    Then The visual should expand to fill the screen
    And other page elements should be hidden
    And the user should see the Back to report button
    When the user clicks on the Back to report button
    Then It should navigate back to the page