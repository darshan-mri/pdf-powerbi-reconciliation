Feature: Focus Mode Interaction for Last 30 Days Summary Table

Scenario: Verify Focus Mode functionality for Last 30 Days Summary table
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on the Focus Mode button/icon for the Last 30 Days Summary table
  Then the table visual should expand to fill the screen
  And the column headers and rows should be clearly visible
  And other page elements should be hidden
  And User should see the Back to report button
  When User clicks on the Back to report button
  Then it should navigate back to the page