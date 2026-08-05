Feature: Rent Trends in Residential Occupancy & Rent Insights Report

  Scenario: User Views Rent Trends Chart
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the "Residential Occupancy & Rent Insights" report
    And the user scroll down to the report
    And clicks on "Rent Trends" button
    Then the x and y axes names and data should be loaded
      | Axis | Name             |
      | x    | Month-Year       |
      | y    | Avg Monthly Rent |
      | z    | Avg Market Rent  |
    When the user hovers over a data point on the chart
    Then the tooltip value for that data point should be displayed
      | Month-Year       |
      | Avg Monthly Rent |
      | Avg Market Rent  |
    When the user selects a data point on the chart
    Then the data related to the selected data point should be displayed in key cards and other visuals