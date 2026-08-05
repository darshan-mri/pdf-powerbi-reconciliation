Feature: Last 30 days Summary table

Scenario: Verify table headers and record selection
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  Then table headers along with proper data should be loaded
  When User selects any of the records from the table
  Then the data related to the selected record should be displayed in key cards and other visuals