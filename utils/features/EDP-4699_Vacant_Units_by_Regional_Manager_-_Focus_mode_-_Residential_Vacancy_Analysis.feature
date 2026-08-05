Feature: Reseidential Vacancy Analysis

  Scenario: User interacts with the Vacant Units by Regional Manager chart in Focus Mode

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And navigates to the Vacant Units by Regional Manager chart
    And clicks on the Focus Mode button/icon for the chart
    Then the visual should expand to fill the screen
    And other page elements should be hidden
    And the user should see the "Back to report" button

    When the user clicks on the "Back to report" button
    Then it should navigate back to the page