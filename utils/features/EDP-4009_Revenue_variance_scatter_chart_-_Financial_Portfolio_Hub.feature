Feature: Financial Portfolio Hub

  Scenario: User interacts with the Revenue Variance Scatter Chart and associated visuals
      Given User logs into Power BI
      When User opens the Financial Portfolio Hub report from the workspace
      And User opens More Details from the Revenues keycard
      Then User sees the Revenue Variance Scatter Chart on scrolling down
      And the X and Y axes should be properly labeled as "Period" and "Revenue" respectively
      And User should see the Entities displayed at the top of the chart
      And User should see the "Revenue Variance to Budget" range slider on the X-axis and "Revenue Variance to Budget %" range slider on the Y-axis
      When User moves any of the sliders on the X-axis or Y-axis
      Then the values and visuals in the scatter chart should update according to the selected range
      When User hovers over any point in the scatter chart
      Then User should see a tooltip with the following details:
        | Entity                       |
        | Revenue Variance to Budget   |
        | Revenue Variance to Budget % |
      When User selects any point in the scatter chart
      Then User should see that the opacity of unselected points is reduced
      And the visuals and values of the Revenue Line Stacked Column Combo Chart and Revenue Table should update based on the selected point
      When User hovers over the selected or any unselected points in the scatter chart
      Then User should see a tooltip with the following details:
        | Entity                       |
        | Revenue Variance to Budget   |
        | Revenue Variance to Budget % |
      When User hovers over the bar in the Revenue Line Stacked Column Combo Chart
      Then User sees a tooltip with the following details:
        | Period      |
        | Revenue     |
        | Highlighted |
      When User hovers over the line in the Revenue Line Stacked Column Combo Chart
      Then User sees a tooltip with the following details:
        | Period |
        | Budget |
      And the tooltip values should match the selected point in the Revenue Variance Scatter Chart
      When User clicks the Focus Mode icon in the Revenue Variance Scatter Chart
      Then the visual should be displayed in full screen with the values intact
      And there should be a back button to navigate back to the home page
      When User hovers over the Filters icon in the Revenue Variance Scatter Chart
      Then User should see the applied filters
      When User selects the already selected point in the scatter chart or clicks anywhere in the scatter chart
      Then the visuals and values should be reverted in the Revenue Variance Scatter Chart, Revenue Table, and Revenue Line Stacked Column Combo Chart
      When User applies any single or combination of filters from the filters pane
      Then the visuals and values should update according to the filters applied