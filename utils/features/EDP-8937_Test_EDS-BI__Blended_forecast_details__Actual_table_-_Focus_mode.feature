Feature: B&F Financial Details

  Scenario: User interacts with the Blended Forecast Details: Actuals table Focus Mode
Given User logs into PowerBI
And User Opens Financial Details report from the workspace
When User clicks on Focus mode for the Blended Forecast details: Actual table
Then the Forecast details: Actual table should be displayed in full screen with the lines and values intact with a back button to navigate back to the home page