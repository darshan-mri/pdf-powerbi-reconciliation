Scenario Outline: Verify that data gets populated for 'Monthly Other Income' in Rent Roll Table is as same as data available in PDF
  Given User logs into Power BI
  And User selects Workspace
  When User opens the report
  Then the Rent Roll table headers along with proper data should be loaded
  And User should be able to select the Building Id from the Filter pane
  When User selects the required Building ID in the Filter Pane
  Then Monthly Other Income Column data should display as same as in PDF