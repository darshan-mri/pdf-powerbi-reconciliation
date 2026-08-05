Feature: Key Card Details

Scenario: Verify chart display for key cards
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on More Details from the key cards
  Then the chart for the corresponding key cards should be displayed