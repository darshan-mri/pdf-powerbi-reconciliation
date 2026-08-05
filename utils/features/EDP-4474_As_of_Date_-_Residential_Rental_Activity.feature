Feature: Display As Of Date in Report

Scenario: Verify that the As Of Date is correctly displayed
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  Then the As Of Date displayed should be the current date or last refreshed date
  And it should follow the format mm/dd/yyyy