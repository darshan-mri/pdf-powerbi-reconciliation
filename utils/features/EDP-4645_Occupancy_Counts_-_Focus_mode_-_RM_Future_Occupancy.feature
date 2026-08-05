Feature: Residential Future Occupancy

  Scenario: Expanding the Table Visual and Navigating Back to the Report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User clicks on the Focus Mode button/icon for the table
    Then The table visual should expand to fill the screen
    And The column headers and rows should be clearly visible
    And Other page elements should be hidden
    And The user should see the "Back to report" button
    When User clicks on the "Back to report" button
    Then It should navigate back to the page