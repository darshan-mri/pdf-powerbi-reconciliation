Feature: Vacancy Analysis Chart

Scenario: Verify scatter chart and data point interactions for Vacancy %
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on More Details from the Vacancy % key card
  Then the scatter chart with proper data should be loaded
  When User hovers the mouse over a data point
  Then the tooltip value for the data point should be displayed
  When User clicks on any of the data points from the chart
  Then the data related to the data point should be displayed in key cards and other visuals