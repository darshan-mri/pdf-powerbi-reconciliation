Feature: B&F Financial Details
Scenario Outline: User views and interacts with the YTD Variance % line chart
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    Then User should see the YTD Variance % line chart
    And User should see the lines in the graph if values are present for the default period selected
    And User should see the legend for the lines in the graph
    And User should see the X-axis with the period range that is selected
    And User should see the Y-axis with YTD Variance % range
    Given User hovers on a point in the line graph
    Then User should see the following tooltip details: <Tooltip>
    Given User views the YTD Variance % line chart
    Then User should see the following legend: <Legend>

    Examples:
      | Tooltip                                | Legend                                 |
      | Non Recoverable Operating Expenses     | Non Recoverable Operating Expenses     |
      | Recoverable Operating Expenses         | Recoverable Operating Expenses         |
      | Net Operating Income                   | Net Operating Income                   |
      | Other Income                           | Other Income                           |
      | Total Operating Revenue                | Total Operating Revenue                |