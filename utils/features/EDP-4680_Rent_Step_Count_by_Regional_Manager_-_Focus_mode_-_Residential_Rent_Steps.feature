Feature: Residential Rent Steps - Focus Mode Interaction for Rent Step by Regional Manager Chart in Power BI

  Scenario: Verifying Focus Mode for Rent Step by Regional Manager chart
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And the user navigates to the Rent Step by Regional Manager chart
    And clicks on the Focus Mode button/icon for the chart
    Then the visual should expand to fill the screen
    And other page elements should be hidden
    And the user should see the Back to report button
    When the user clicks on the Back to report button
    Then it should navigate back to the page