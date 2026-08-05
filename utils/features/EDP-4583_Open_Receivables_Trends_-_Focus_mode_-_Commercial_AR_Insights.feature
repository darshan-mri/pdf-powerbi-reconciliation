Feature: Commercial AR Insights - Open Receivables Trends Focus Mode

  Scenario: User interacts with Focus Mode for a table
    Given the user is logged into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on the Focus Mode button/icon for the table
    Then the table visual should expand to fill the screen
    And the column headers and rows should be clearly visible
    And other page elements should be hidden
    And the user should see a Back to report button
    When the user clicks on the Back to report button
    Then it should navigate back to the original view