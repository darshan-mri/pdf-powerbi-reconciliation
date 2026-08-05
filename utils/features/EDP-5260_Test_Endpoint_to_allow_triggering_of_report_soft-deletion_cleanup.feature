#Postman - Non-proxied - Authenticated - Pbi Reports - Clean SoftDeleted

Scenario: 1
Given one or more PbiReport records marked as soft deleted (IsDeleted = 1) (see PbiReport scenario table below for details)
When I call the endpoint (see postman request Pbi Reports - Clean soft deleted) to cleanup a soft deleted records belonging to a specific OrganisationWorkspace
Then those PbiReport's belonging to the active pbi workspace as selected by the request that I made, should be hard deleted (removed from the PbiReport table) and the corresponding reports in the pbi service (both the Reports and Version workspaces) also deleted. All other reports, should remain both in the db and in the portal service
(If the default address or workspace name doesn't work, make sure to try the templateworkspaceid i.e.0A17048A-AC8B-4C4C-8E3D-10660399A83C)

Scenario: 2
Given one or more PbiReport records marked as soft deleted (IsDeleted = 1) (see PbiReport scenario table below for details)
When I call the endpoint (see postman request Pbi Reports - Clean soft deleted) to cleanup a soft deleted records belonging to a specific OrganisationWorkspace that does NOT have any soft deleted records
Then this request should return successfully without affecting other soft deleted records

Scenario: 3

Given one or more Report records marked as soft deleted (IsDeleted = 1) (see Report scenario table below for details)
When I call the endpoint (see postman request Pbi Reports - Clean soft deleted) to cleanup a soft deleted records belonging to a specific OrganisationWorkspace
Then those Report's and their child PbiReport records belonging to the active pbi workspace identified in the request that I made, should be hard deleted (removed from the Report and PbiReport table) and the corresponding reports in the pbi service (both the Reports and Version workspaces) also deleted

Scenario: 4

Given a Report that is hidden by another Report and that hidden Report is marked as soft deleted (IsDeleted = 1).
When I call the endpoint (see postman request Pbi Reports - Clean soft deleted) to cleanup a soft deleted records belonging to a specific OrganisationWorkspace
Then the Report and its child PbiReport record belonging should be hard deleted (removed from the Report and PbiReport table) the corresponding report in the pbi service (both the Reports and Version workspaces) also deleted the Report that was hiding the now deleted Report.HidesReportId is updated nullNP