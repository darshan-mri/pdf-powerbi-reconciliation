Feature: Financial NOI Analysis Report
Scenario: Interacting with Revenue Line Chart
  Given the user is logged into PowerBI
  And the user has opened the Financial NOI Analysis report from the workspace
  Then the user should see a Revenue line chart with:
    #Legends:
    | Comparison |
    | Actual Revenue |
  And Y-axis showing amount range
  And X-axis showing period range
  And Lines with data points for:
    | Total Revenue |
    | Rent |
    | Recoverable Income |
    | Other Income |

Scenario: Filtering by Revenue Type
  When the user selects any revenue type
  Then the chart values and visuals should update based on the selected type
  And the NOI Variance Breakdown table should update accordingly

Scenario: Tooltip on Comparison Line
  When the user hovers over any point on the Comparison line
  Then the tooltip should display:
  | Period |
  | Comparison |
  | Actual Revenue |
  And the tooltip values should match the NOI Variance Breakdown table

Scenario: Tooltip on Actual Revenue Line
  When the user hovers over any point on the Actual Revenue line
  Then the tooltip should display:
  | Period |
  | Comparison |
  | Actual Revenue |
  And the tooltip values should match the NOI Variance Breakdown table

Scenario: Selecting a Point on the Chart
  When the user selects any point on the chart
  Then the selected point should be highlighted
  And the opacity of unselected points should be reduced
  And the visuals and values of NOI by Entity chart and NOI Variance Breakdown table should update based on the selected point
  When the user hovers over the selected point
  Then the tooltip should display:
  | Period |
  | Comparison |
  | Actual Revenue |