Feature: Residential AR Insights

  Scenario: User interacts with Monthly Trends Details table in Focus Mode
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User clicks on the "Monthly Trends Details" table
    And User clicks on the Focus Mode button/icon for the table
    Then The table visual should expand to fill the screen
    And The column headers and rows should be clearly visible
    And Other page elements should be hidden
    And User should see the "Back to report" button
    When User clicks on the "Back to report" button
    Then It should navigate back to the page