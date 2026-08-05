Feature: B&F Financial Details

Scenario: User interacts with the Blended Forecast Details: Actuals table
Given User logs into PowerBI
And User Opens Financial Details report from the workspace
When User clicks on the Portfolio column of the Blended Forecast Details: Actuals table
Then the values in the Blended Forecast Details: Actuals table should be sorted
When User clicks any of the month columns in the Blended Forecast Details: Actuals table
Then that column should be highlighted
And User should see the changes reflected in the YTD Variance % line chart and Blended Forecast:Actuals table as per the selected column
When User clicks on the value in Portfolio column
Then the selected row should be highlighted and opacity of unselected rows should be reduced
And User should see the changes reflected in the YTD Variance % line chart and Blended Forecast:Actuals table as per the selected row
When User selects any single value under any of the month column
Then the selected value should be highlighted
And User should see the changes reflected in the YTD Variance % line chart and Blended Forecast table as per the selected value
When User clicks on the plus icon of any value in Portfolio column of Blended Forecast Details:Actuals table
Then Account filter name column and values should be displayed in the Blended Forecast Details:Actuals table
When User clicks on the plus icon of any value in Account column of Blended Forecast Details:Actuals table
Then Account Name column and values should be displayed in Blended Forecast Details table
When User clicks on any value in Account filter name / Account Name column
Then the selected row should be highlighted and opacity of unselected rows should be reduced
And User should see the changes reflected in the YTD Variance % line chart and Blended Forecast:Actuals table as per the selected row
When user deselect the selected column or row the report should be reverted back as before.