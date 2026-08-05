Feature: Display Updated Date in Report

Scenario: Verify that the updated date is correctly displayed
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  Then the updated date should be displayed in the format mm/dd/yyyy HH:MM:SS AM/PM TimeZone