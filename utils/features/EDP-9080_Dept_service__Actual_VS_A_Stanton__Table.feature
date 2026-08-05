Feature: B&F Portfolio Hub

Scenario: User interacts with the Debt Service keycard and table
Given User logs into PowerBI
When User opens Financial Portfolio Hub report from the workspace
And User Clicks on the Debt Service keycard
Then User sees the Debt Service table on scrolling down
When User clicks Focus Mode icon from the Debt Service table
Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page
When User hovers of the Filters icon in the Debt Service table
Then User should see the applied filters
When User clicks on any of the column names in the Debt Service table
Then User sees the values sorted based on the clicked column name
When User selectes any row in the Debt Service table
Then the visuals and values should get updated in the Debt Service line stacked column combo chart and Debt Service scatter chart as per the selected row in the Debt Service table
When User hovers over the bar of Debt Service line stacked column combo chart
Then User sees tooltip with the below details
|Period       |
|Debt Service |
When User hovers over the line of Debt Service line stacked column combo chart
Then User sees tooltip with the below details
|Period |
|Budget |
And the tooltip values should match the selected row in the Debt Service table
When User hovers over the scatter point in the Debt Service Variance scatter chart
Then User should see tooltip with the below details
|Entity name |
|Variance    |
|Variance %  |
And the tooltip values should match the selected row in the Debt Service table
When User clicks again on the selected row
Then User should see the selection is reverted
And the values and visuals of Debt Service line stacked column combo chart and Debt Service variance scatter chart is also reverted