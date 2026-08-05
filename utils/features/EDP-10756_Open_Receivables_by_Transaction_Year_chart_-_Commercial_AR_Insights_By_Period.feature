Feature: Commercial AR Insights by Period - Open Receivables by Transaction Year Chart

  Scenario: User views and interacts with Open Receivables by Transaction Year Chart
    Given the user is logged into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on Open Receivables by Transaction Year
    Then the clustered column chart with proper data along with <Legends> should be loaded
      | Total Billings      |
      | Total Open Charges  |
      | Total Credits       |
    And the X axis should be properly allined in decsensing order
    When the user hovers the mouse over a bar
    Then the tooltip value should be displayed for the bar upon which the mouse is hovered over
      | Year    |
      | Legends | 
    When the user clicks on any of the bars from the chart
    Then the information related to the bar should be displayed in key cards and other visuals