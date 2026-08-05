Feature: Commercial Stacking Plan

  Scenario: Using Focus Mode in Unit Information chart
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And the user navigates to the Unit Information chart
    And clicks on the Focus Mode button/icon from the chart
    Then the visual should expand to fill the screen
    And other page elements should be hidden
    And the user should see the "Back to report" button
    When the user clicks on the "Back to report" button
    Then it should navigate back to the page