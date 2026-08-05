Feature: Residential Occupancy & Rent Insights Report

  Scenario: Verify axes names and data in Avg Loss to Lease Trends Chart
    Given User logs into Power BI
    And User selects the workspace
    When User opens the Residential Occupancy & Rent Insights report
    Then the x and y axes names and data should be loaded for Avg Loss to Lease Trends
      | Axis | Name          |
      | x    | Year          |
      | y    | Loss to Lease |
    When User hovers over a data point
    Then the tooltip value for the hovered data point should be displayed
      | Month&Year  |
      | Loss to Lease |
    When User selects any data point from the chart
    Then the data related to the selected data point should be displayed in key cards and other visuals