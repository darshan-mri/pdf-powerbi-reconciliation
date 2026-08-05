Feature: Greenlaw Financial Details
Scenario Outline: Verify that value for 'Non-Recoverable Operating Expenses' in YTD Comparison table appears as same as in PDF
  Given: User logs into PowerBI
  And User Selects Workspace
  When User Opens the Greenlaw Financial Details report
  Then User should see YTD Comparison table
  And Non-Recoverable Operating Expenses in YTD Copmarison table should appears as same as in PDF with <Signs> as mentioned in PDF
  Examples:
  	| Signs |
  	| Positive |
  	| Negative |