Feature: Open Receivables trends chart - CM AR Patterns by Period
Scenario: User views and interacts with the Open Receivables Trends Stacked Column Chart
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the user should see the data loaded properly for the Open Receivables Trends Stacked Column chart along with the following legends:
      | Billings     |
      | Credits      |
      | Open Charges |
    And x-axis should be sorted in descending Order
    And hovering over a bar should display a tooltip with the following values:
      | Month - Year                  |
      | Open Charges/Billings/Credits |
    When User selects any of the bars from the chart
    Then the information related to the selected bar should be displayed in key cards and other visuals
    When User deselects the selected bar
    Then the values in the visuals should be reverted back
    When User right-clicks on a bar and selects "Show as Table"
    Then the value must be displayed as a table along with the back button
    When User clicks on the back button
    Then the visual should be reverted back to the stacked column chart