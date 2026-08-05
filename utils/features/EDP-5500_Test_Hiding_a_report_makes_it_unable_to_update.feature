Given I'm in AIG and I select any report and clicking the ellipsis select Copy as new dashboard
When I name the report Z1[Reportname] and Create Dashboard
And I click File -> Save and then the ellipsis Publish 
And select Publish As New Dashboard, and Publish
Then a new report will be created

When I select any report and clicking the ellipsis select Copy as new dashboard
When I name the report Z2[Reportname] and Create Dashboard
And I make any visual change such as deleting the main visual and I click File -> Save and then the ellipsis Publish 
And select Publish As Replacement Dashboard, select Z1[ReportName] and Publish
Then Z2 will be published under the name Z1 and the visual change confirms it is Z2

When I select any report and clicking the ellipsis select Copy as new dashboard
When I name the report Z3[Reportname] and Create Dashboard
And I click File -> Save and then the ellipsis Publish 
And select Publish As Replacement Dashboard
Then Z1 will be greyed out and I will be unable to replace/hide it

When I discard Z3 and select Z1 click the ellipsis and select Create New Draft
And using the default name select Create Draft
And I click File -> Save and the ellipsis Publish keeping the provided name
Then it will be published #This used to cause an error#

Given I'm accessing the database either through Azure or MSSQL
When I right click dbo.Report and select Top 1000
And add to the bottom of the query WHERE TenantKey = 'P123456' #Replacing P123456 with whatever client the above have been tested in
And run it, near the bottom will be the Z1 reports #You will see two, one is the original Z1, the other is the replacement Z1
And I scroll over to see the column HidesReportId, one of the Z1 will have a value here indicating it is the replacement report
And I scroll back to the left and select and copy the ID of the replacement report
And add below the query   
#Delete FROM [dbo].[Report]
#Where ID = '22629D20-4E75-49C6-824D-0E2C47F5265E' -- Replacing that number with the copied ID
And run this query
When I return to AIG, refresh the page, and look at the Z1 report
Then the report will be the original Z1 report as identified by the original visuals