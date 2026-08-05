Given I'm in postman, authorized in the INT environment
And I run the request {{baseUrl}}/api/internal/reports
Then the results will contain PbiDatasetId, TemplateWorkspaceName, TemplateWorkspaceId, OrganisationWorkspaceQualifier