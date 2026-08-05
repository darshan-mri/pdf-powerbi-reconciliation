Feature: NaN/Null/Nil in Visuals

Scenario: Verify that NaN/Null/Nil values are not displayed in visuals
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  Then NaN/Null/Nil/Blank values should not be displayed in any of the visuals