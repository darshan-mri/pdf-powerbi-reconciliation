Given I am logged into the Azure Query editor for mriqaaig01 https://portal.azure.com/#@MRISOFTWARE.onmicrosoft.com/resource/subscriptions/c398eb55-b057-45f9-8fe3-cfb0034418f5/resourceGroups/rg-qa-aig-eastus/providers/Microsoft.Sql/servers/mriqaaig01eastus/databases/mriqaaig01/queryEditor
When I enter # UPDATE [dbo].[Report] SET LatestProblem = N'{"Message":"Report Regression Test 2 needs to saved in order to enable the deployment of this report. Please edit the report and click \u0027Save\u0027.","Source":0,"IsRecoverable":true,"TraceId":"00-12c74eebf042c3c3f2c17e32fac813f1-1c7c94d4a426e0ad-00"}'WHERE Name = N'Regression Test 2'; # without the number sign into the query editor and run it
Then this will cause the report to display an error in AIG QA Dev https://qa-mriagorainsights.redmz.mrisoftware.com/

Given I am logged into AIG QA Dev https://qa-mriagorainsights.redmz.mrisoftware.com/
When I click All items below the Dashboards title
And scroll down to Regression Test 2
Then it should have red error text below saying 'Needs attention'

When I click the ellipsis in the top right to select Edit dashboard
And click File, and Save at the top left
When I return to the Azure Query editor
And enter # SELECT * FROM [dbo].[Report] WHERE Name = N'Regression Test 2'; # without the number sign into the query editor and run it
Then it should return this report and the LatestProblem field will be blank

When I enter # SELECT * FROM [dbo].[PbiReport] WHERE Name = N'Regression Test 2'; # without the number sign into the query editor and run it
Then it should return this report and the field BackupReportId will have an alphanumeric sequence and beside it CreatedDate should match when the report was saved in AIG