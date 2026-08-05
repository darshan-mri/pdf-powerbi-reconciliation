Feature: Commercial Rent Roll

  Scenario: User expands Annual Rent chart in Focus Mode
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And navigates to the Annual Rent chart
    And clicks on the Focus Mode button/icon from the chart
    Then the visual should expand to fill the screen
    And other page elements should be hidden
    And the user should see the Back to report button
    When the user clicks on the Back to report button
    Then it should navigate back to the page