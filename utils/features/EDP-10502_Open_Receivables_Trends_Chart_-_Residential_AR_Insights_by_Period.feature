Feature: Residential AR Insights by Period - Open Receivables Trends Chart

  Scenario: Verifying chart interaction and tooltip display
    Given the user logs into Power BI
    And selects the appropriate workspace
    When the user opens the Residential AR Insights by Period report
    Then the Open Receivables Trends Chart should be displayed with the following legends:
      | Legends       |
      | Billing       |
      | Credit        |
      | Open Charges  |
    And the names of the axes should be aligned properly:
      | Axes  | Name                             |
      | x     | Month & Year                     |
      | y     | Billing, Credit, and Open Charges|
    And X-axis should be sorted in descending order
    And the user selects any of the bars from the chart
    Then the data related to the selected bar should be displayed in key cards and other visuals
    When the user hovers over a bar
    Then the tooltip value for the bar should be displayed:
      | Tooltip Value                           |
      | Month & year                            |
      | Selected Legend                         |
      | % of Charges (value) Open               |
      | % of Charges (value) Received           |
    When the user deselects the selected bar
    Then the values in the visuals should be reverted back
    When User right-clicks on a bar and selects "Show as Table"
    Then the value must be displayed as a table along with the back button
    When User clicks on the Back to report button
    Then the visual should be reverted back to the stacked column chart