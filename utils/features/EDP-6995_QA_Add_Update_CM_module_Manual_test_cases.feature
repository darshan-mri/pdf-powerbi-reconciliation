Tool Tip observation 

Given User logs into Power BI
And User selects the workspace
When user opens the report (Open receivable Details table) hover on the Graph present
Then the report should show the values present in the Tool Tip without blank

Visuals in report

Given User logs into Power BI
And User selects the workspace
When User opens the report
Then the report should load without breaking any visual

Keycards checking 

Given User logs into Power BI
And User selects the workspace
Then Check the Key cards details by clicking see more details
And Check see more details values are matching with Keycards

See all transactions

Given User logs into Power BI
And User selects the workspace
Then Click on see all transactions link in Open receivable table
And check values are coming for Billings , credits and open Amount

As of Date

Given User logs into Power BI
And User selects the workspace
When User opens the report
Then as of date should not be blank
And the as of date by default should be current date

Filter Pane 

Given User logs into Power BI
And User selects the workspace
When User opens the report
Then the filter pane should not be open by default

Filter Reset

Given User logs into Power BI
And User selects the workspace
When User opens the report
And 
Then the Filter Reset button should be displayed
And Should reset the filter conditions back to default when clicked