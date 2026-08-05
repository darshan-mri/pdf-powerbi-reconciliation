Feature: Residential Lease Execution - Table Focus Mode and Navigation

  Scenario: User interacts with the Lease Details table visual in Focus Mode and navigates back
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the Focus Mode button/icon for the Lease Details table
    Then The table visual should expand to fill the screen
    And The column headers and rows should be clearly visible
    And Other page elements should be hidden
    And The user should see the "Back to report" button
    When The user clicks on the "Back to report" button
    Then It should navigate back to the page