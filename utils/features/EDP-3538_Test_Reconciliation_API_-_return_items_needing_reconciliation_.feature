Given I am logged into Dev AIG ( https://dev-mriagorainsights.redmz.mrisoftware.com/ ) 
When I go to the bottom right, clicking my user name, and clicking Select a different client ID
And I select P123456 from the list and confirm

When I go to the + icon on the report dashboard to add a new report
And I select any dataset #dataset is irrelevant for the testing, any will do#
And click add
And opening any icon on the right in the Data panel, click and drag any line to the dashboard body #Again specifics do not matter#
When I click File, Save As, and name the report ZTestSc1, and Create dashboard
And I click File and Save
And select Publish Draft from the ellpsis in the top right
Then I have created the first test dashboard

When I repeat the above using the dashboard names ZTestSc2, ZTestSc5, ZTestSc6, ZTestSc7, and ZTestSc8 #ZTestSc3 and ZTestSc4 are created differently below and are skipped in this step#
Then I have created six test dashboards in total

When I go to the + icon on the report dashboard to add a new report
And I select any dataset #dataset is irrelevant for the testing, any will do#
And click add
And opening any icon on the right in the Data panel, click and drag any line to the dashboard body #Again specifics do not matter#
When I click File, Save As, and name the report ZTestSc3, and Create dashboard
And I click File and Save
Then I have created a test draft dashboard
And I repeat this with ZTestSc4
Then I have now created all eight test dashboards

When I select ZTestSc8 from the left panel
And I click Create Draft from the top right ellpsis, confirm Create Draft with default name
And I make a minor change, such as moving a tile on the dashboard
And I select Save from the File Menu
And select Publish Draft from the from the ellpsis in the top right
And I repeat this process two more times
Then I have created a test dashboard with multiple versions

When I login to the AIG Dev database in Azure ( https://portal.azure.com/#@MRISOFTWARE.onmicrosoft.com/resource/subscriptions/c398eb55-b057-45f9-8fe3-cfb0034418f5/resourceGroups/rg-dev-aig-eastus/providers/Microsoft.Sql/servers/mridevaig01eastus/databases/mridevaig01/overview )
And select Query Editor from the left panel
And click Continue as [Username] #If it provides an error saying you cannot access it, toggle the VPN and refresh the page, it may take a few times to work#
And put ' SELECT TOP (1000) * FROM [dbo].[Report] ORDER BY Name Desc ' into the query editor and run
Then it will return the test dashboards at or near the top

When I put the following into the query editor SELECT TOP (1000) * FROM [dbo].[Report] Where Name = 'ZTestSc1'
Then it should only return that dashboard
And I change the query to Delete FROM [dbo].[Report] Where Name = 'ZTestSc1'
And put the following in the query editor ' SELECT TOP (1000) * FROM [dbo].[Report] ORDER BY Name Desc '
Then it should return the test dashboards at or near the top and ZTestSc1 should no longer appear

When I put the following into the query editor SELECT TOP (1000) * FROM [dbo].[PbiReport] Where Name = '[Draft] ZTestSc3'
And confirm this pulls up only the draft for this dashboard
And change the query to DELETE FROM [dbo].[PbiReport] Where Name = '[Draft] ZTestSc3'
And I rerun SELECT TOP (1000) * FROM [dbo].[PbiReport] Where Name = '[Draft] ZTestSc3'
Then it should not return anything, confirming the deletion

When I put the following into the query editor SELECT TOP (1000) * FROM [dbo].[Report] Where Name = 'ZTestSc5'
Then it should only return that dashboard
And I change the query to Delete FROM [dbo].[Report] Where Name = 'ZTestSc5'
And put the following in the query editor ' SELECT TOP (1000) * FROM [dbo].[Report] ORDER BY Name Desc '
Then it should return the test dashboards at or near the top and ZTestSc5 should no longer appear

Given I'm logged into PowerBi (https://app.powerbi.com/home?experience=power-bi)
When I go to workspaces at the bottom left
And I select the latest dev_P123456_reports_[timestamp]
And I scroll down to find ZTestSc2, click the Ellpsis beside it and Delete the report
When I go to workspaces at the bottom left
And I select the latest dev_P123456_versions_[timestamp]
And I scroll down to find [Draft]ZTestSc4, click the Ellpsis beside it and Delete the report
And I scroll down to find every version of ZTest6 v000#, click the ellpsis beside it and Delete them 
And I scroll down to find the latest version of ZTest7 v000#, click the ellpsis, Save a copy, and save it updating the v000# by 1
And I scroll down to find the latest version of ZTest8 v000#, click the ellpsis and delete
Then all eight test dashboards are in the correct state

Given I am in Postman and selecting Environments on the bottom left
When I select MRI DSG - Dev and ensure the Current value of impersonatingClientId is to P123456, and if it must be changed click Save at the top right
And I click Collections at the top left
And I select Non-proxied, Authenticated, Get Reconiliation, and click Send
Then the results should match the expected results in the comments below