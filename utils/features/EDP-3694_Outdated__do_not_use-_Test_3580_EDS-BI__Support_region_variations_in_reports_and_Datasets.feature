##This test no longer functions as is

Given I am in PowerBi, in the DeployTest workspace I rename Fin Model [region_emea] to Fin Model [region_na]
And change Financial Model [region_na] to Financial Model notregion_na

Given I am in Postman and have set deployClientId in dev from P123456 to AIGDEPLOYAPP and deployTemplateWorkspaceId to 90bde98b-6a81-45ef-876b-e9ace21d8e79 (DeployTest workspace)
And I Deploy Client and wait
When the deployment is complete
Then Get Deployment Status should provide an error that the Dataset region does not made the report region

Given I am back in PowerBi
And I change Fin Model [region_na] back to Fin Model [region_emea]
And I change More NA Finance [region_na] to More NA Finance
When I attempt deployment from Postman 
When the deployment is complete
Then Get Deployment Status should provide an error that the Dataset region does not made the report region

#Given I have had a dev change the region of AIG
#When I got to the Azure database and run the query editor with: delete from Report where TenantKey = 'AIGDEPLOYAPP'
#And I am in Postman and have set deployClientId in dev from P123456 to AIGDEPLOYAPP and templateWorkspaceIdOrName to 'Deploy Test'
#And I Deploy Client and wait
#When the deployment is complete
#Then in the PowerBi workspace and AIG Dev only the reports and datasets that are of the correct region or regionless will show up.