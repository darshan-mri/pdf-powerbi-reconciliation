Feature: Residential Rent Steps - Focus Mode Interaction for Table Visual in Power BI

  Scenario: Verifying Focus Mode for table visual
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the Focus Mode button/icon for the table
    Then the table visual should expand to fill the screen
    And the column headers and rows should be clearly visible
    And other page elements should be hidden
    And the user should see the Back to report button
    When the user clicks on the Back to report button
    Then it should navigate back to the page