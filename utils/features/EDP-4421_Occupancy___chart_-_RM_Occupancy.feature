Feature: Residential Occupancy - Occupancy % Chart Interactions

  Scenario: User interacts with the Occupancy % chart
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on Occupancy % with a chart icon
    Then The chart with proper data should be loaded
     When the user hovers the mouse over a bar from the graph
    Then The tooltip value for the bar upon which the mouse is hovered over should be displayed
      | Building ID - Name  |
      | Prior Year Occupancy %  |
      | As of Date Occupancy %  |
    When The user selects any of the Point from the chart
    Then The data related to the selected point should be displayed in key cards and other visuals