Feature: Residential AR Insights

  Scenario: User interacts with the map in Focus Mode
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User clicks on the Focus Mode button/icon for the map
    Then The user should be able to see a zoomed-in view of the map
    And The user should see the "Back to report" button
    When User clicks on the "Back to report" button
    Then It should navigate back to the page