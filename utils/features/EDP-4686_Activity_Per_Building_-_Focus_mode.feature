Feature: Activity Per Building - Focus Mode

Scenario: Verify Focus Mode functionality for Activity Per Building chart
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And User navigates to the Activity Per Building chart
  And clicks on the Focus Mode button/icon for the chart
  Then the visual should expand to fill the screen
  And other page elements should be hidden
  And User should see the Back to report button
  When User clicks on the Back to report button
  Then it should navigate back to the page