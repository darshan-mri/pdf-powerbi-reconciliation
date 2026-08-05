Feature: Residential AR Insights

  Scenario: User interacts with Open Receivables Trends chart in Focus Mode
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User navigates to the "Open Receivables Trends" chart
    And User clicks on the Focus Mode button/icon for the chart
    Then The visual should expand to fill the screen
    And Other page elements should be hidden
    And User should see the "Back to report" button
    When User clicks on the "Back to report" button
    Then It should navigate back to the page