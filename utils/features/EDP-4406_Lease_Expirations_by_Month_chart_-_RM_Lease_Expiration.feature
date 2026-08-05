Feature: Residential Lease Expiration - Lease Expiry Chart Interactions

  Scenario: User interacts with the Lease Expiration - Chart and views detailed data
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on Lease Expiration - Chart
    Then The x and y axes along with legends should be aligned properly
    And The line and stacked column chart with proper data should be loaded based on the Group by option selected
    When User hovers the mouse over a data point
    Then The tooltip value for the data point should be displayed as follows:
      | Lease expiry month              |
      | Selected grouping Name          |
      | Lease Expiration Expiring Units |
      | Expiration date          |
      | Target Lease expiration  |
      | Total expiring rent      |
      | Targeted Expiration %    |
    When User clicks on any of the data points from the chart
    Then The data related to the data point should get displayed in key cards and other visuals
    When the user clicks on the same data point
    Then the data should revert back to its original state