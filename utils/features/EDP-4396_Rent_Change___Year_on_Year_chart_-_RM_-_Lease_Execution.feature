Feature: Residential Lease Execution - Line Chart Interaction and Data Display

  Scenario: User logs into Power BI, interacts with the line chart, and views related data
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The x and y axes along with legends should be aligned properly
    And The line chart with proper data should be loaded
    When User hovers the mouse over a data point
    Then The tooltip value for the data point should be displayed with following details
     | Current year Rent Change     |
     | Prior year rent change       |
     | Two years prior rent change   |
    When User clicks on any of the data points from the line chart
    Then The data related to the selected data point should be displayed in key cards and other visuals
    When User deselects the data point
    Then all the data should change in key cards and other visuals accordingly