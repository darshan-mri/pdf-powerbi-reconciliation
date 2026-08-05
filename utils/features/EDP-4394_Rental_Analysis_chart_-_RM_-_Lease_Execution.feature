Feature: Residential Lease Execution - Chart Interaction and Data Display

  Scenario: User logs into Power BI, interacts with the stacked column chart, and views related data
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The x and y axes along with legends should be aligned properly
    And The stacked column chart with proper data should be loaded
    And the chart should be sorted in descending order
    When User hovers the mouse over a bar from the chart
    Then The tooltip value for the bar should be displayed with following details
     | Month year   |
     | Rent/Prior rent/ Optimum rent |
    When User clicks on any of the bars from the chart
    Then The data related to the selected bar should be displayed in key cards and other visuals
    And When User deselects the data point, all the data should change in key cards and other visuals accordingly