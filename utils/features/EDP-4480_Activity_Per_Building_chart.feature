Feature: Activity Per Building Chart

Scenario: Verify chart alignment and data point interactions
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  Then the axes and legends should be aligned properly
  And the line and stacked column chart with proper data should be loaded
  When User hovers the mouse over a data point
  Then the tooltip value for the data point should be displayed
  When User clicks on any of the data points from the chart
  Then the data related to the data point should be displayed in key cards and other visuals