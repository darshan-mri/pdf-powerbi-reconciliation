Feature: Residential AR Insights

  Scenario: User views Open Receivables by Property and interacts with the chart
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User clicks on "Open Receivables by Property"
    Then The stacked bar chart with proper data should be loaded
    And The X and Y axis are labeled as "Transaction Amount" and "Property ID - Name" respectively
    When User hovers the mouse over a bar
    Then The tooltip value should be displayed for the bar upon which the mouse is hovered over
    When User clicks on any of the bars from the chart
    Then The data related to the selected bar should be displayed in key cards and other visuals