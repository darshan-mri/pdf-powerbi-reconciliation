##This test may need to be rewritten, or reworked as it requires a second person doing deployment and losing the time involved with that
#If this test is to be run it requires someone who can manually deploy AIG
Given I am connected to the dev database
When I run the SQL query
"""
UPDATE [dbo].[TemplateWorkspace]
SET TemplatePbiWorkspaceName = 'AIG Production'
WHERE ProductNameOrFamily = 'MRI Agora Insights';
"""
Then TemplatePbiWorkspaceName for MRI Agora Insights will change from AIG Prod to AIG Production

Given someone has triggered a manual deployment of AIG APP
When everything has finished running then I run the query
"""
SELECT TOP (1000) [Id]
      ,[ProductNameOrFamily]
      ,[TemplatePbiWorkspaceName]
      ,[AuthorizedServicePrincipalId]
      ,[PeriodEnd]
      ,[PeriodStart]
      ,[TenantKey]
      ,[LastUpdatedBy]
      ,[LastUpdatedDate]
  FROM [dbo].[TemplateWorkspace]
"""
Then TemplatePbiWorkspaceName for MRI Agora Insights will change back to AIG Prod from AIG Production