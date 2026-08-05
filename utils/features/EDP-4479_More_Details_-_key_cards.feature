Feature: Display Detailed Charts/Tables

Scenario: Verify that detailed charts/tables are displayed for key cards
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on More Details from the key cards
  Then the chart/table for the corresponding key cards should be displayed