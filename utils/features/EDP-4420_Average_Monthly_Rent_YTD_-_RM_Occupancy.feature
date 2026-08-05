Feature: Residential Occupancy - Line Chart Interactions

  Scenario: User interacts with the Line Chart and views data
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The x and y axes along with proper data should be loaded for the chart
    And The title should be suffixed with the Reporting Range selected
    When The user hovers the mouse over a data point
    Then The tooltip value for the data point should be displayed
    When The user selects any of the data points from the line chart
    Then The relevant data should be displayed in key cards and other visuals