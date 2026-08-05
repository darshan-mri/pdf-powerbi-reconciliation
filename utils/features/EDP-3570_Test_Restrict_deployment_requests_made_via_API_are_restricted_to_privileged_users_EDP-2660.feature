#Test is written for Dev, use whatever environment and client ID that is appropriate/available for this testing
Given I have test accounts setup with each different permission level in AIG
#Currently test accounts are
#Creator User aig.creatoruser@mrisoftware.disabled
#Viewer User aig.vieweruser@mrisoftware.disabled
#Support User aig.supportuser@mrisoftware.disabled
#Global Services User aig.globalservicesuser@mrisoftware.disabled
#Client Administrator aig.clientadmin@mrisoftware.disabled
#System Administrator aig.systemadmin@mrisoftware.disabled
#All have the same password, contact Mykel to get the passwords
##Please note they are currently set up correctly, and are intended to stay that way, but if any results don't match up check the user roles in the database to ensure they are still setup correctly
When in Postman in the top right corner I ensure the environment is MRI DSG - dev
And in Environments at the left side MRI DSG - dev is selected and Current ClientID is AIGDEPLOYAPP
When I click Collections at the top left, MRI DSG, and click Authorization
And at the bottom I Clear cookies, then Get New Access Token
And I enter [Account], and use token
When I click Deploy Client, and Send
Then it should return the expected value from below

When I click Get Deployment Status, and Send
Then it should return the expected value from below

When Deployment is complete according to Get Deployment Status (or could not run in the previous step)
And I go to the AIG Dev Azure database query editor ( https://portal.azure.com/#@MRISOFTWARE.onmicrosoftcom/resource/subscriptions/c398eb55-b057-45f9-8fe3-cfb0034418f5/resourceGroups/rg-dev-aig-eastus/providers/Microsoft.Sql/servers/mridevaig01eastus/databases/mridevaig01/overview )
And run the query SELECT TOP (1000) * FROM [dbo].[PbiOrganisationWorkspace] Where Status = 'Inactive'
And I copy the full Id of any of the results ((If nothing comes up a Deployment must be run from an authorized account, this will create some Inactive entries))
And in Postman I select Deployment Cleanup, and paste the Id over {{deployTemplateWorkspaceId}} in the address bar at the top, and Send
Then it should return the expected value from below