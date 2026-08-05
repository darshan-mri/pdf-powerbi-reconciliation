Given I am logged into AIG Dev Environment (https://dev-mriagorainsights.redmz.mrisoftware.com/) as a ClientAdmin or SysAdmin, and confirmed/changed in the bottom right that I am using ClientID P123456
When I click All items in the left window it will display all reports
#If there are already three test dashboards than can be modified or deleted skip to the next scenario, otherwise create them following the below. This is only required when making new test dashboards#
And click any report, and click the ellipsis in the top right, and click Edit dashboards
And when I click Save As label it as TestAIG. Repeat this two other times creating TestPBI and TestBoth #suffixes AIG/PBI/Both help ensure the right dashboards are deleted in the right place#
Then there should be three test reports that can be deleted

When I login to PowerBi (https://app.powerbi.com/home), and select Workspaces in the bottom left
And I search for and click into the workspace dev_P123456_Reports_[TIMESTAMP] #Sometimes there is more than one workspace with the same name, use the time stamp to ensure the most recent version of the workspace is selected#
And I scroll done until the three test dashboards are visible
And click the ellipsis beside TestPBI, and click Delete, and confirm
And click the ellipsis beside TestBoth, and click Delete, and confirm
Then only the test TestAzure should be visible in PBi 

Given I am logged into the Azure database for this environment mridevaig01 (https://portal.azure.com/#@MRISOFTWARE.onmicrosoft.com/asset/SqlAzureExtension/Database/subscriptions/c398eb55-b057-45f9-8fe3-cfb0034418f5/resourceGroups/rg-dev-aig-eastus/providers/Microsoft.Sql/servers/mridevaig01eastus/databases/mridevaig01)
When I click Query editor (preview)
And confirm my authorization #Authorization will frequently be lost. If it says "Cannot open server 'mridevaig01eastus' requested by the login. Client with IP address..." I can confirm I'm on the VPN, perform an ipconfig release/renew, and if neither of those work the bottom of the message says "Allowlist IP ..." and click that to get authorization to access. Adding exceptions isn't ideal, so try the VPN and ipconfig first#
And click Tables, rightclick dbo.Report and Select Top 1000 Rows, it will open up a new query
When I edit the query at the end to become SELECT TOP (1000) * FROM [dbo].[Report] where Name like '%test%' #If you didn't create test reports for this, then search the names of the reports you used#
And drag over the column edge so I can see all of the Id displayed
And find the Id for TestAzure and TestBoth 
And edit the query so it now reads SELECT TOP (1000) * FROM [dbo].[Report] where Id = 'e0d5670e-3167-4ccf-b53c-6eb965b18d05' #Replace with the appropriate ID#
And run the query, it will return only the selected test report
When I edit the query so it says Delete FROM [dbo].[Report] where Id = 'e0d5670e-3167-4ccf-b53c-6eb965b18d05'
And run the query it will only delete that selected report
And I repeat this with the ID for the second test report
When I rerun the query SELECT TOP (1000) * FROM [dbo].[Report] where Name like '%test%'
Then only TestPBI should remain of the three tests

When I return to AIG, and click the Administration gear on the left side
And click Reconcilliation screen
Then the Reconcilliation screen will show that TestPBI exists in Agora Insights, but does not exist in PowerBi, and TestAzure will show that it is in PowerBi, but not in Agora Insights, and TestBoth should not be visible anywhere