Feature: Residential Future Occupancy

  Scenario: Expanding the Occupied Units Chart and Navigating Back to the Report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User navigates to the Occupied Units chart
    And User clicks on the Focus Mode button/icon from the chart
    Then The visual should expand to fill the screen
    And Other page elements should be hidden
    And The user should see the "Back to report" button
    When User clicks on the "Back to report" button
    Then It should navigate back to the page