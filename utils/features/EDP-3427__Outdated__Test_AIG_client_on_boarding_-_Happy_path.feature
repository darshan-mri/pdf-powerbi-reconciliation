Given a test datalake and datawarehouse have been created and named appropriately in PowerBi, and a testing user group has been created and assigned to a user
#Currently qatest_dev_datalake and qatest_dev_datawarehouse, and AIGDEPLOYAPP exist for this purpose.#
When I'm logged into AIG's Dev environment ( https://dev-mriagorainsights.redmz.mrisoftware.com/dashboards )
And click my username at the bottom right, click Select a different Client ID, and type in AIGDEPLOYAPP
When it asks if I would like to onboard a new client, and I agree
And wait ten minutes #This process takes a while#

#Scenario 1#
Given I open Postman and have the MRI DSG collection imported
#Collection can be found on GitHub, or requested from a team member if GitHub is inaccessible#
When I select MRI DSG - dev from the environments at the top right
And go to the left side panel and click Environrments, click MRI DSG - dev
And for the Current Value column put AIGDEPLOYAPP in the impersonatingClientId and deployClientId rows
And click save 
When I click Collections at the top left
And click the actual title MRI DSG on the left side
And click Authorization from the main screen and scroll to the bottom
When I click Clear cookies and then Get New Access Token
And Delete other Token_StandardUsers if they exist and then click Use Token at the top right
#Tokens last around two hours, if it times out and access is forbideen repeat the above four steps to get a new token#
And I click Get Deployment Status, and Send at the top right
Then it should return a notification that the onboarding is complete
#If the message says it is not complete, generally that something is still loading or refreshing, then attempt this in another five minutes, repeat until complete. Depending on the system this may take a while. If it says there is an authentication error or permission error follow the above steps to get another token and try again, if it does not work ensure you are using an account that is a member of AIGDEPLOYAPP and has it on their profile#

#Scenario 2#
When I login to PowerBi ( https://app.powerbi.com/home )
And click Workspaces at the bottom left 
Then  dev_AIGDEPLOYAPP_Datasets_[Timestamp] , dev_AIGDEPLOYAPP_Reports_[Timestamp] , and dev_AIGDEPLOYAPP_Version_[Timestamp] should be created

#Scenario 3#
When I am logged into the Azure Query editor ( https://portal.azure.com/#@MRISOFTWARE.onmicrosoft.com/resource/subscriptions/c398eb55-b057-45f9-8fe3-cfb0034418f5/resourceGroups/rg-dev-aig-eastus/providers/Microsoft.Sql/servers/mridevaig01eastus/databases/mridevaig01/queryEditor ) and run SELECT * FROM [dbo].[IdentityPrincipal] WHERE Name = 'AIGDEPLOYAPP'
Then it should return an entry for AIGDEPLOYAPP

#Scenario 4#
When I run SELECT * FROM [dbo].[OrganisationWorkspace] WHERE TenantKey = 'AIGDEPLOYAPP'
Then it should return an entry for AIGDEPLOYAPP

#Scenario 5#
When I run SELECT * FROM [dbo].[PbiOrganisationWorkspace] WHERE TenantKey = 'AIGDEPLOYAPP'
Then it should return three entries for AIGDEPLOYAPP
#The three PowerBi workspaces, the IdentityPrincipal, OrganisationWorkspace, and three PbiOrganisationWorkspace are all required for this to be a successful test#

#Then environments must be reset to run these tests again#

When I am logged into the Azure Query editor ( https://portal.azure.com/#@MRISOFTWARE.onmicrosoft.com/resource/subscriptions/c398eb55-b057-45f9-8fe3-cfb0034418f5/resourceGroups/rg-dev-aig-eastus/providers/Microsoft.Sql/servers/mridevaig01eastus/databases/mridevaig01/queryEditor ) and run DELETE * FROM [dbo].[IdentityPrincipal] WHERE Name = 'QATEST'
And run DELETE * FROM [dbo].[OrganisationWorkspace] WHERE TenantKey = 'AIGDEPLOYAPP'
And run DELETE * FROM [dbo].[PbiOrganisationWorkspace] WHERE TenantKey = 'AIGDEPLOYAPP'
And run DELETE * FROM [dbo].[IdentityPrincipal] WHERE TenantKey = 'AIGDEPLOYAPP'
##Note: This can either be done manually as above, or using the Clear Tenant Data script https://github.com/MRI-Software/data-services-gateway/blob/master/tools/db-scripts/Clear%20Tenant%20Data.sql
When I login to PowerBi ( https://app.powerbi.com/home ) 
And click Workspaces at the bottom left 
And delete dev_AIGDEPLOYAPP_Datasets_[Timestamp]
And delete dev_AIGDEPLOYAPP_Reports_[Timestamp]
And delete dev_AIGDEPLOYAPP_Version_[Timestamp]
#Once everything is deleted the next test can be run#

#Scenario 6#
When I click the actual title MRI DSG on the left side
And click Authorization from the main screen and scroll to the bottom
When I click Clear cookies and then Get New Access Token
And Delete other Token_StandardUsers if they exist and then click Use Token at the top right
#Tokens last around two hours, if it times out and access is forbideen repeat the above four steps to get a new token#
When I click into Proxied below MRI DSG and select Deploy Client and Send at the top right
Then after a moment the bottom window will display an id string


Given I open Postman retaining the previous settings
When I click Onboard Client #If Onboard client does not exist, click the ellipsis beside Deploy Clients, make a copy of it called Onboard Client, and put {{baseUrl}}/deploy/onboard/{{deployClientId}} in the field beside Post
And click Send
And then wait ten minutes

#Scenario 7#
When I click Get Deployment Status, and Send at the top right
Then it should return a notification that the onboarding is complete
#If the message says it is not complete, generally that something is still loading or refreshing, then attempt this in another five minutes, repeat until complete. Depending on the system this may take a while. If it says there is an authentication error or permission error follow the above steps to get another token and try again, if it does not work ensure you are using an account that is a member of QATEST and has it on their profile#

#Scenario 8#
When in PowerBi 
And I click Workspaces at the bottom left 
Then  dev_AIGDEPLOYAPP_Datasets_[Timestamp] , dev_AIGDEPLOYAPP_Reports_[Timestamp] , and dev_AIGDEPLOYAPP_Version_[Timestamp] should be created

#Scenario 9#
When I am in the Azure Query editor ( https://portal.azure.com/#@MRISOFTWARE.onmicrosoft.com/resource/subscriptions/c398eb55-b057-45f9-8fe3-cfb0034418f5/resourceGroups/rg-dev-aig-eastus/providers/Microsoft.Sql/servers/mridevaig01eastus/databases/mridevaig01/queryEditor ) and run SELECT * FROM [dbo].[IdentityPrincipal] WHERE Name = 'QATEST'
Then it should return an entry for AIGDEPLOYAPP

#Scenario 10#
When I run SELECT * FROM [dbo].[OrganisationWorkspace] WHERE TenantKey = 'AIGDEPLOYAPP'
Then it should return an entry for AIGDEPLOYAPP

#Scenario 11#
When I run SELECT * FROM [dbo].[PbiOrganisationWorkspace] WHERE TenantKey = 'AIGDEPLOYAPP'
Then it should return three entries for AIGDEPLOYAPP
#The three PowerBi workspaces, the IdentityPrincipal, OrganisationWorkspace, and three PbiOrganisationWorkspace are all required for this to be a successful test#

#Then environments must be reset to run these tests again#

When I am logged into the Azure Query editor ( https://portal.azure.com/#@MRISOFTWARE.onmicrosoft.com/resource/subscriptions/c398eb55-b057-45f9-8fe3-cfb0034418f5/resourceGroups/rg-dev-aig-eastus/providers/Microsoft.Sql/servers/mridevaig01eastus/databases/mridevaig01/queryEditor ) and run DELETE * FROM [dbo].[IdentityPrincipal] WHERE Name = 'QATEST'
And run DELETE * FROM [dbo].[OrganisationWorkspace] WHERE TenantKey = 'AIGDEPLOYAPP'
And run DELETE * FROM [dbo].[PbiOrganisationWorkspace] WHERE TenantKey = 'AIGDEPLOYAPP'
When I login to PowerBi ( https://app.powerbi.com/home ) 
And click Workspaces at the bottom left 
And delete dev_AIGDEPLOYAPP_Datasets_[Timestamp]
And delete dev_AIGDEPLOYAPP_Reports_[Timestamp]
And delete dev_AIGDEPLOYAPP_Version_[Timestamp]
#Once everything is deleted the next test cna be run#

When in Postman I click Non-Proxied, then System Ops, then in the Authorization tab I follow the previous instructions to procure a token
And click CreateSystemAdmin 
When it returns Status: 200 OK
And then wait ten minutes
#If it does not provide the Status 200, then refer to above to ensure that the permissions are set correctly, and token is authenicated#

#Scenario 12#
When I click Get Deployment Status, and Send at the top right
Then it should return a notification that the onboarding is complete
#If the message says it is not complete, generally that something is still loading or refreshing, then attempt this in another five minutes, repeat until complete. Depending on the system this may take a while. If it says there is an authentication error or permission error follow the above steps to get another token and try again, if it does not work ensure you are using an account that is a member of QATEST and has it on their profile#

#Scenario 13#
When in PowerBi 
And I click Workspaces at the bottom left 
Then  dev_AIGDEPLOYAPP_Datasets_[Timestamp] , dev_AIGDEPLOYAPP_Reports_[Timestamp] , and dev_AIGDEPLOYAPP_Version_[Timestamp] should be created

#Scenario 14#
When I am in the Azure Query editor ( https://portal.azure.com/#@MRISOFTWARE.onmicrosoft.com/resource/subscriptions/c398eb55-b057-45f9-8fe3-cfb0034418f5/resourceGroups/rg-dev-aig-eastus/providers/Microsoft.Sql/servers/mridevaig01eastus/databases/mridevaig01/queryEditor ) and run SELECT * FROM [dbo].[IdentityPrincipal] WHERE Name = 'QATEST'
Then it should return an entry for AIGDEPLOYAPP

#Scenario 15#
When I run SELECT * FROM [dbo].[OrganisationWorkspace] WHERE TenantKey = 'AIGDEPLOYAPP'
Then it should return an entry for AIGDEPLOYAPP

#Scenario 16#
When I run SELECT * FROM [dbo].[PbiOrganisationWorkspace] WHERE TenantKey = 'AIGDEPLOYAPP'
Then it should return three entries for AIGDEPLOYAPP
#The three PowerBi workspaces, the IdentityPrincipal, OrganisationWorkspace, and three PbiOrganisationWorkspace are all required for this to be a successful test#

#Scenario 17#
When I am logged into the Azure Query editor ( https://portal.azure.com/#@MRISOFTWARE.onmicrosoft.com/resource/subscriptions/c398eb55-b057-45f9-8fe3-cfb0034418f5/resourceGroups/rg-dev-aig-eastus/providers/Microsoft.Sql/servers/mridevaig01eastus/databases/mridevaig01/queryEditor ) and run DELETE * FROM [dbo].[IdentityPrincipal] WHERE Name = 'QATEST'
And run DELETE * FROM [dbo].[OrganisationWorkspace] WHERE TenantKey = 'AIGDEPLOYAPP'
And run DELETE * FROM [dbo].[PbiOrganisationWorkspace] WHERE TenantKey = 'AIGDEPLOYAPP'
And run DELETE * FROM [dbo].[PbiOrganisationWorkspace] WHERE TenantKey = 'AIGDEPLOYAPP'
When I login to PowerBi ( https://app.powerbi.com/home ) 
And click Workspaces at the bottom left 
And delete dev_AIGDEPLOYAPP_Datasets_[Timestamp]
And delete dev_AIGDEPLOYAPP_Reports_[Timestamp]
And delete dev_AIGDEPLOYAPP_Version_[Timestamp]

When I'm in Postman, and click Environments in the left panel, MRI DSG - dev
And I set the the parameters so the Current Value of the impersonatingClientId is MRIQWEB, and deployClientId to P123456
And click save, and click Collections to return to the Workspace
And I click Deploy Client, and run
Then after many minutes it should redeploy the client and the workspaces will be reset