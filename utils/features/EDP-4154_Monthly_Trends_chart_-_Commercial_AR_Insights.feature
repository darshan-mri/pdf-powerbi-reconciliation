Feature: Commercial AR Insights - Monthly Trends Chart Reports

  Scenario: User views and interacts with Monthly Trends
    Given the user is logged into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on Monthly Trends
    Then the X axis should be Month & Year
    And the Y axis should be Amount
    And x- axis Month & year should be sorted in descending order
    And Total Open Charges, Total Billings, and Total Credits legends should be aligned properly
    And the line chart with proper data should be loaded
    When the user hovers the mouse over a data point
    Then the tooltip value for the data point should be displayed
    When the user clicks on any of the data points from the line chart
    Then the information related to the data point should be displayed in key cards and other visuals