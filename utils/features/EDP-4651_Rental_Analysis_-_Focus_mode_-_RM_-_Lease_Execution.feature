Feature: Residential Lease Execution - Focus Mode and Navigation

  Scenario: User interacts with the Rental Analysis chart and navigates in and out of Focus Mode
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User navigates to the Rental Analysis chart
    And clicks on the Focus Mode button/icon from the chart
    Then The visual should expand to fill the screen
    And Other page elements should be hidden
    And The user should see the "Back to report" button
    When The user clicks on the "Back to report" button
    Then It should navigate back to the page