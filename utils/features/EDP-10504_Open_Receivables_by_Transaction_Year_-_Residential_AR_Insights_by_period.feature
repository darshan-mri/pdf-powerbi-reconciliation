Feature: Residential AR Insights by Period - Open Receivables by Transaction Year

  Scenario: User views and interacts with Total Open AR by Year
    Given the user is logged into Power BI
    And the user selects the workspace
    When the user opens the Residential AR Insights by Period report
    And Clicks on Open Receivables by Transaction Year
    Then the following <Legends> should be displayed for Open Receivables by Transaction Year Chart
      | Total Open Charges  |
      | Total Billings      |
      | Total Credit        |
    When the User hovers on any of the bar Open Receivables by Transaction Year chart
    Then the Tooltip Fields for the bar should be displayed
      | ChargedTransactionDate Year |
      | 'Legends'                   |
    And the ToolTip values should match with the Keycard values
    And the names of the axes should be aligned properly:
      | Axes  | Name                             |
      | x     | Year                             |
      | y     | Open Charges                     |
    And X-axis should be sorted in descending order