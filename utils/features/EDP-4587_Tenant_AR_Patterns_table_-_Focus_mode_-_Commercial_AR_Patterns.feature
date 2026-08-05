Feature: Commercial AR Patterns

  Scenario: Interact with Tenant AR Patterns table in Focus Mode
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the report
    And clicks on the Focus Mode button/icon for the Tenant AR Patterns table
    Then the table visual should expand to fill the screen
    And the column headers and rows should be clearly visible
    And other page elements should be hidden
    And the user should see an Exit Focus Mode button/icon
    When the user clicks on the Exit Focus Mode button/icon
    Then it should navigate back to the page