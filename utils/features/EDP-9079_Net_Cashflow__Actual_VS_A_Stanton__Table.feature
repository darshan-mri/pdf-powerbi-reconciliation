Feature: B&F Portfolio Hub

Scenario: User interacts with the Net Cashflow keycard and table
Given User logs into PowerBI
When User opens Financial Portfolio Hub report from the workspace
And User Clicks on the Net Cashflow keycard
Then User sees the Net Cashflow table on scrolling down
When User clicks Focus Mode icon from the Net Cashflow table
Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page
When User hovers of the Filters icon in the Net Cashflow table
Then User should see the applied filters
When User clicks on any of the column names in the Net Cashflow table
Then User sees the values sorted based on the clicked column name
When User selectes any row in the Net Cashflow table
Then the visuals and values should get updated in the Net Cashflow line stacked column combo chart and Net Cashflow scatter chart as per the selected row in the Net Cashflow table
When User hovers over the bar of Net Cashflow line stacked column combo chart
Then User sees tooltip with the below details
|Period       |
|Net Cashflow |
When User hovers over the line of Net Cashflow line stacked column combo chart
Then User sees tooltip with the below details
|Period |
|Budget |
And the tooltip values should match the selected row in the Net Cashflow table
When User hovers over the scatter point in the Net Cashflow Variance scatter chart
Then User should see tooltip with the below details
|Entity name |
|Variance    |
|Variance %  |
And the tooltip values should match the selected row in the Net Cashflow table
When User clicks again on the selected row
Then User should see the selection is reverted
And the values and visuals of Net Cashflow line stacked column combo chart and Net Cashflow variance scatter chart is also reverted