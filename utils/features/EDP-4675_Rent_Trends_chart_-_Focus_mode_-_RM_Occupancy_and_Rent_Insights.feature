Feature: Residentials Occupancy and Rent Insights

  Scenario: Interacting with the Rent Trends chart in focus mode
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User navigates to the Rent Trends chart
    And User clicks on the Focus Mode button/icon for the bar graph
    Then The bar graph visual should expand to fill the screen
    And Other page elements should be hidden
    And The user should see the Back to report button
    When The user clicks on the Back to report button
    Then It should navigate back to the page