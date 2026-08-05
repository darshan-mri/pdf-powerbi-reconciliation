##This test is under review to see if it is necessary and still functions as expected. Sections commented out no longer apply
Given I have run a deployment from Postman, Dev environment
When I go to the Azure AIG Dev database, and Select Top 1000 from Reports
Then the templateDatasetName and TemplateReportName should have the relevant values

#Given I am in AIG Dev, and I select All Reports
#When I click the ellpsis and make a new dashboard, naming it ZCopy of [Dashboard]
#And got back to Postman, and change the deployWorkspaceId to 90bde98b-6a81-45ef-876b-e9ace21d8e79 and save
#And I run the deployment, and wait 10 minutes, and run deployment status
#Then the deployment should have succeeded with no issue

#Given I'm in the Azure Dev database and rerun the Select Top 1000 from Reports
#And I scroll to find ZCopy of [Dashboard]
#Then the IsDetached value should be true    --- Detached is no longer triggered this way

Given I am in AIG Dev, and refresh to load the new reports
#When I make a copy  of each report (What was this for?)
And I go to the Deploy Test workspace in PowerBi
And selecting any report I go to Settings and make a copy of the report calling it Copy[Report]
And then selecting the original and going to Settings and deleting it 
Then the copied report should still exist while the original is removed

#When I rerun the Select Top 1000 in Azure AIG Dev
#Then it should have the correct name in templateDatasetName --Deploys function differently now