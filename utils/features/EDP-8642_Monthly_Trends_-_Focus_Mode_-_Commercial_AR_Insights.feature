Feature: Commercial AR Insights - Monthly Trends - Focus Mode

  Scenario: User views and interacts with Monthly Trends and Focus Mode
    Given the user logs into the Power BI application
    And the user selects the workspace
    When the user opens the report
    And clicks on Monthly Trends
    Then the user should see the data loaded properly with their corresponding tooltip values for the following visuals
    When the user clicks on the Focus Mode button/icon for the table
    Then the table visual should expand to fill the screen
    And the column headers and rows should be clearly visible
    And other page elements should be hidden
    And the user should see a Back to report button
    When the user clicks on the Back to report button
    Then it should navigate back to the original view