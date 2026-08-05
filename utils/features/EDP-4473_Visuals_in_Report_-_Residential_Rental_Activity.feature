Feature: Residential Rental Activity

Scenario: Verify that the report loads correctly
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  Then the report should load without breaking any visuals