Feature: Residential Lease Expiration - Focus Mode Interaction with Lease Expirations Table

  Scenario: User interacts with the Lease Expirations table in Focus Mode
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the Lease Expirations - table
    And clicks on the Focus Mode button/icon from the table
    Then The table visual should expand to fill the screen
    And The column headers and rows should be clearly visible
    And Other page elements should be hidden
    And The user should see the "Back to report" button
    When The user clicks on the "Back to report" button
    Then It should navigate back to the page