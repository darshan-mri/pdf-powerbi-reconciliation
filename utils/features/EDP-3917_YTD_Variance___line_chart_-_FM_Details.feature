Feature:Financial Details 
Scenario: User views YTD Variance % line chart in the Financial Details report
  Given User logs into PowerBI
  And User opens the Financial Details report from the workspace
  Then User should see the YTD Variance % line chart
  And User should see lines in the graph if values are present for the default period selected
  And User should see the following legends for the lines in the graph:
    | Legends                    |
    | Account Filter Name        |
  And User should see the X-axis with the period range in ascending order for the selected period
  And User should see the Y-axis with the YTD Variance % range
  When User hovers over a point in the line graph
  Then User should see the following tooltip details:
    | Tooltip                                   |
    | Period                                    |
    | Values for Account Filter Name            |
  When User selects any month from the chart
  Then Other visuals should be updated according to the selected month
    | Variance Type Selection in Filter Pane  |
    | Blended Forecast                        |
    | YTD Comparison                          |
  
    | Other Visuals                   |
    | Selected Varaince Type          |
    | Selected Variance Type Details  |
    | variance Details                |
  When User deselects the selected month
  Then All data should be reverted back to the original state