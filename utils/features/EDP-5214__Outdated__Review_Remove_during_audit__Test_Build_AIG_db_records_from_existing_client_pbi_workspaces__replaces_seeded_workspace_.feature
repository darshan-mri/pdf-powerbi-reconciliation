##When restoring from a deleted client, region needs to be supplied in postman, when restoring from deleted reports it is not
Background:
Given I am logged into GlobalProtect and the SQL database mridevaig01eastus.database.windows.net 
And have Postman pointing to the correct environment open to the body of Seed Database (MRI DSG, Non-Proxied, Authenticated, Seed Database)
And each scenario is run twice, once after running Scenario 0, and again after running Scenario 0.5
And the default Select Top 1000 query is used for [dbo].[Report] to confirm the data is restored

Scenario: 0 Removing existing organisation and organisation workspace (AIGDEPLOYAPP is an example, replace with whatever clientid you wish to remove)
Given I am logged into GlobalProtect and the SQL database mridevaig01eastus.database.windows.net
When I run the query #DELETE FROM [dbo].[Report]WHERE TenantKey = 'AIGDEPLOYAPP'
And run the query #DELETE FROM [dbo].[OrganisationWorkspace] WHERE TenantKey = 'AIGDEPLOYAPP'
Then AIGDEPLOYAPP information will no longer be in the database
Scenario: 0.5 Removing some reports to prove the data is being restored
Given I am accessing the SQL database 
When I run #DELETE FROM [dbo].[Report] WHERE TenantKey = 'AIGDEPLOYAPP' AND Name like '%Finan%'
Then it should remove all reports with "Finan" in the name

Scenario: 1 With TemplateWorkspaceID (fdc1cbfe-85d7-4941-bc2a-f613af853a5b is an example)
Given I add a templateworkspaceid like fdc1cbfe-85d7-4941-bc2a-f613af853a5b where it says TemplateWorkspaceID
And click send
Then the system will repopulate the information recreating the organisation and workspace and the associated reports

Scenario: 2 Wrong TemplateWorkspaceID (02EFC197-152B-44AB-925B-0997BF10B930 is another example if something else used previously)
Given I add a templateworkspaceid like 02EFC197-152B-44AB-925B-0997BF10B930 where it says TemplateWorkspaceID
And click send
Then Postman will return a 409 error

Scenario: 3 Invalid TemplateWorkspaceID (B53A0B11-7FDF-52D0-BCE8-D1CE90AD0D1A is an example, any madeup ID should work)
Given I add a templateworkspaceid like B53A0B11-7FDF-52D0-BCE8-D1CE90AD0D1A where it says TemplateWorkspaceID
And click send
Then Postman will return a 404 error

Scenario: 4 With TemplateWorkspace Name (AIG Prod is an example)
Given I add a TemplateWorkspaceName like AIG Prod 
And click send
Then the system will repopulate the information recreating the organisation and workspace and the associated reports

Scenario: 5 With Wrong TemplateWorkspace Name (Deploy Test is an example)
Given I add a TemplateWorkspaceName like Deploy Test 
And click send
Then the system will return a 409 Conflict

Scenario: 6 With Invalid TemplateWorkspace Name (Waffle iron is an example)
Given I add a TemplateWorkspaceName like Waffle iron 
And click send
Then the system will return a 404 Not found error

Scenario: 7 With TemplateWorkspaceID and Name (fdc1cbfe-85d7-4941-bc2a-f613af853a5b is an example and needs to be the template the organisation was onboarded with, Deploy Test is an example for a workspace not used before)
Given I add a templateworkspaceid like fdc1cbfe-85d7-4941-bc2a-f613af853a5b where it says TemplateWorkspaceID
And put Deploy Test where it says TemplateWorkspaceName
And click send
Then the system will repopulate the information recreating the organisation and workspace and the associated reports ignoring the wrong TemplateWorkspaceName

Scenario: 8 No TemplateWorkspaceID or Name
Given I add a null for templateworkspaceid where it says TemplateWorkspaceID
And put null for templateworkspacename
And click send
Then the system will return a 400 error asking for either ID or Name

Scenario: 9 No TemplateWorkspaceID or Name
Given I add a null for templateworkspaceid where it says TemplateWorkspaceID
And put null for templateworkspacename
And click send
Then the system will return a 400 error asking for either ID or Name

Scenario: 10 DatasetWorkspaceId, ReportWorkspaceId, and VersionWorkspaceId provided
Given I am in PowerBi and I look for the previous workspaces, not the current
And in the previous ReportWorkspace and I select and delete one of the reports with "Finan" in the name to verify with later
And I take the IDs from the URLs for each workspace ( https://app.powerbi.com/groups/{{WorkspaceID}} )
And I put the corresponding IDs in Postman
And click send
Then the system will restore the data, with the deleted report excluded

Scenario: 11 DatasetWorkspaceId, ReportWorkspaceId, and VersionWorkspaceId not provided
Given I have deleted the report in PowerBi per Scenario 10 am in PowerBi 
And I make sure that Dataset, Report, and Version WorkspaceIds are set to null
And click send
Then the system will restore the data including the deleted report (because it will be using the most recent version which did have the deleted file)

Scenario: 12 DatasetWorkspaceId, ReportWorkspaceId, and VersionWorkspaceId mismatch
Given I am in PowerBi and I look for the previous workspaces, not the current
And I take the IDs from the URLs one of the previous workspaces and the other two current ( https://app.powerbi.com/groups/{{WorkspaceID}} )
And I put the corresponding IDs in Postman
And click send
Then the system will return dataset not found

Scenario: 13 With Region
Given I add a templateworkspaceid like fdc1cbfe-85d7-4941-bc2a-f613af853a5b where it says TemplateWorkspaceID
And for region I put a different region than the organisation was setup with
And click send
Then the system will repopulate the information recreating the organisation and workspace and the associated reports ignoring the new region

Scenario: 14 Unauthorized account
Given I am logged into postman with an account that does not have permission to deploy that client and workspace
And I perform Scenario 1 again
Then the system will return a 403 insufficient resource error

Scenario: 15 Non-region region backup
Given I have onboarded a client without a region previously
When I use the Reseed with a region set
Then the system provides a mismatch error

Scenario: 16 Region non-region backup
Given I have onboarded a client with a region previously
When I use the Reseed without a region set
Then the system provides a dataset not found error

Scenario: 17 Duplicate Reports
Given I am in PowerBi and finding the most recent ReportWorkspace for my clientid
And I copy a report, renaming it to be the exact same as the original
And I add a templateworkspaceid like fdc1cbfe-85d7-4941-bc2a-f613af853a5b where it says TemplateWorkspaceID
And click send
Then the system will provide a 501 


Scenario: 18 Cannot find Template
Given I am in the SQL database and enter this query
#UPDATE [dbo].[TemplateWorkspace]
#SET TemplatePbiWorkspaceName = 'Waffle Iron'
#WHERE TemplatePbiWorkspaceName = 'AIG Prod';
And click send
Then I will receive a 404 error

And I run the query
#UPDATE [dbo].[TemplateWorkspace]
#SET TemplatePbiWorkspaceName = 'AIG Prod'
#WHERE TemplatePbiWorkspaceName = Waffle Iron';
Then the TemplateWorkspaceName will be set back to normal

Scenario: 19 Legacy version
Given I am in AIG, select a report, create a dashboard from it, save and publish
And after waiting for a few minutes I go to PowerBi, in Reports I delete the duplicate copy of the report
And in Versions I find the most recent version of that report and rename it with v0001 at the end instead of vs_
And in Postman I click send
Then the system may return a Parent/Child error, and a not supported error

Scenario: 20 Invalid date
Given I am in AIG, select a report, create a dashboard from it, save and publish
And after waiting for a few minutes I go to PowerBi, in Reports I delete the duplicate copy of the report
And in Versions I find the most recent version of that report and rename it with a different date at the end
And in Postman I click send
Then the system may return a Parent/Child error, and a not supported error