Feature: Commercial AR Patterns

  Scenario: Interact with Billings and Payments bar graph in Focus Mode
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the report
    And the user navigates to the Billings and Payments bar graph
    And clicks on the Focus Mode button/icon for the bar graph
    Then the bar graph visual should expand to fill the screen
    And other page elements should be hidden
    And the user should see an Exit Focus Mode button/icon
    When the user clicks on the Exit Focus Mode button/icon
    Then it should navigate back to the page