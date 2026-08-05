Feature: B&F Portfolio Hub

Scenario: User interacts with the Non-Opex Variance scatter chart
Given User logs into PowerBI
When User opens Financial Portfolio Hub report from the workspace
And User click on the Non-OpEx keycard
Then User sees the Non-OpEx variance scatter chart on scrolling down
And User should see the Entities in the top of the chart
And User should see Non-OpEx Variance to Budget range slider in the X-axis and Non-OpEx Variance to Budget % range slider in the Y-axis
When User moves any of the slider
Then the values/visuals in the scatter chart should be as per the selected range
When User hovers over any of the point in the scatter chart
Then User should see tooltip with the below details
|Entity Name |
|Variance    |
|Variance %  |
When User selects any of the points in the scatter chart
Then User should see the opacity of the unselected points should be reduced
And the visuals and values of Non-OpEx line stacked column combo chart and Non-OpEx table should be updated as per the selected point
When User hovers over selected or any unselected points in the scatter chart
Then User should see tooltip with the below details
|Entity Name |
|Variance    |
|Variance %  |
When User hovers over the bar of Non-OpEx line stacked column combo chart
Then User sees tooltip with the below details
|Period      |
|Non-OpEx    |
When User hovers over the line of Non-OpEx line stacked column combo chart
Then User sees tooltip with the below details
|Period |
|Budget |
And the tooltip values should match the selected point in the Non-OpEx variance scatter chart
When User clicks Focus Mode icon from the Non-OpEx variance scatter chart
Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page
When User hovers of the Filters icon in the Non-OpEx variance scatter chart
Then User should see the applied filters
When User selects the already selected point in the scatter chart / clicks any where in the scatter chart
Then the visuals and values should be reverted in the Non-OpEx variance scatter chart, Non-OpEx table and Non-OpEx line stacked column combo chart
When User applies any single or combination of filters from the filters pane
Then the visuals and values should be updated as per the filters applied