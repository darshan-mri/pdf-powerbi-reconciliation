Given User logs into PowerBI
And User Select the workspace
When User Opens the report
And User clicks on More Details from <Key Card>
Then the x and y axes should be aligned properly
When User hovers the mouse over any of the bars from the chart
Then the tooltip value for the bar should be displayed
When User clicks on any of the bars from the chart
Then the data related to the selected bar should be displayed in key cards and other visuals
When clicks on the Focus Mode button/icon for any of the <Key Card> in the chart
Then the visual should expand to fill the screen
And other page elements should be hidden
And the user should see the Back to report button 
When the user clicks on the Back to report button 
Then it should navigate back to the page
|Key Card|
|Vacancy Rate|
|Total Days Vacant|
|Vacancy Loss|