Feature: B&F Financial Details
  
Scenario: User interacts with the Blended Forecast: Actuals Legend
Given User logs into PowerBI
And User opens the Financial Details report from the workspace
When User views the "Blended Forecast: Actual" table
Then User should see the forecast legend in light green color
And User should see that the total values are highlighted with the same light green color as the forecast legend