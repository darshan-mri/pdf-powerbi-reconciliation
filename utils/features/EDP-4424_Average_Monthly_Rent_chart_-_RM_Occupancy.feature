Feature: Residential Occupancy - Average Monthly Rent Chart Interactions

  Scenario: User interacts with the Average Monthly Rent chart
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on Average Monthly Rent with a chart icon
    Then The x and y axes along with proper data should be loaded
    When the user hovers the mouse over a bar from the graph
    Then The tooltip value for the bar upon which the mouse is hovered over should be displayed
      | Building ID - Name  |
      | Prior Year Average Monthly rent |
      | As of Date Average Monthly Rent  |
    When the user selects any of the bars from the chart
    Then The data related to the selected bar should be displayed in key cards and other visuals