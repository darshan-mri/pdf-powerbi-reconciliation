Feature: B&F Portfolio Hub

Scenario: User interacts with the Revenues keycard and scatter chart
Given User logs into PowerBI
When User opens Financial Portfolio Hub report from the workspace
And User opens More Details from Revenues keycard
Then User sees the Revenue variance scatter chart on scrolling down
And User should see the Entities in the top of the chart
And User should see Revenue Variance to Budget range slider in the X-axis and Revenue Variance to Budget % range slider in the Y-axis
When User moves any of the slider
Then the values/visuals in the scatter chart should be as per the selected range
When User hovers over any of the point in the scatter chart
Then User should see tooltip with the below details
|Entity Name                        |
|B&F Revenue Variance to Variance   |
|B&F Revenue Variance to Variance % |
When User selects any of the points in the scatter chart
Then User should see the opacity of the unselected points should be reduced
And the visuals and values of Revenue line stacked column combo chart and Revenue table should be updated as per the selected point
When User hovers over selected or any unselected points in the scatter chart
Then User should see tooltip with the below details
|Entity Name                        |
|B&F Revenue Variance to Variance   |
|B&F Revenue Variance to Variance % |
When User hovers over the bar of Revenue line stacked column combo chart
Then User sees tooltip with the below details
|Period      |
|Revenue     |
When User hovers over the line of Revenue line stacked column combo chart
Then User sees tooltip with the below details
|Period |
|Budget |
And the tooltip values should match the selected point in the Revenue variance scatter chart
When User clicks Focus Mode icon from the Revenue variance scatter chart
Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page
When User hovers of the Filters icon in the Revenue variance scatter chart
Then User should see the applied filters
When User selects the already selected point in the scatter chart / clicks any where in the scatter chart
Then the visuals and values should be reverted in the Revenue variance scatter chart, Revenue table and Revenue line stacked column combo chart
When User applies any single or combination of filters from the filters pane
Then the visuals and values should be updated as per the filters applied