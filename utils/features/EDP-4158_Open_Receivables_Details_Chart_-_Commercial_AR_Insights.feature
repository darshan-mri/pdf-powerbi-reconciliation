Feature: Commercial AR Insights - Open Receivables Details Chart

  Scenario Outline: User views and interacts with Open Receivables Details Chart
    Given the user is logged into Power BI
    And the user has selected the "Commercial AR Insights" workspace
    When the user opens the "Commercial AR Insights Report"
    And clicks on "Open Receivables Details" Chart Button
    Then the chart should display bars with properly aligned axes:
      | Axis | Label                        |
      | x    | Total Open Charges           |
      | y    | <Selected Group By Filter From Filter Pane>   |
    When the user hovers over a bar in the chart
    Then a tooltip should appear showing:
      | Group By Filter Name From Filter Pane  |
      | Total Open Charges                     |
    When the user selects a bar from the chart
    Then the details related to the selected bar should be displayed in key cards and other visuals:
      | Key Card            |
      | Total Open Charges  |
      | Billings            |
      | Credits             | 
      | Open Charges        |