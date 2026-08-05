Given I am logged into the Azure Query editor for mriqaaig01 https://portal.azure.com/#@MRISOFTWARE.onmicrosoft.com/resource/subscriptions/c398eb55-b057-45f9-8fe3-cfb0034418f5/resourceGroups/rg-qa-aig-eastus/providers/Microsoft.Sql/servers/mriqaaig01eastus/databases/mriqaaig01/queryEditor
When I enter # SELECT TOP (1000) * FROM [dbo].[ReportActivityRecord] ORDER BY LastUpdatedDate DESC # without the number sign into the query editor and run it
When the query has run I scroll down until I find a report where the LastUpdatedDate is not today, and note the ReportId which is needed for the next query
And I enter # SELECT TOP (1000) * FROM [dbo].[Report] where id = 'ReportId from the last step' it will provide the report name

Given I am logged into AIG QA Dev https://qa-mriagorainsights.redmz.mrisoftware.com/
When I click All items below the Dashboards title
And scroll down to find the report selected above
And click into the report to view it (Just view, no changes or interaction)

When I return to the Azure Query editor and rerun SELECT TOP (1000) * FROM [dbo].[ReportActivityRecord] ORDER BY LastUpdatedDate DESC 
Then the report in question should show up at or near the top, and the LastUpdatedDate should match the time the report was accessed