#Before starting you need multiple different user accounts with various access and permissions.
#Account 1- Access to all client ids, no client roles, only sys admin as a global roles
#Account 2- Access to all client ids, every client set to admin, no global roles
#Account 3- Access to all client ids, no client roles, support user as a global role
#Account 4- Access to main client id, no client roles, only sys admin as global
#Ensure the client ids PS12999, AD43999, and 1100NTS are empty and deleted in the dev database and PowerBi
#This uses five different ClientIds, MRIQWEB and P123456 are not used in the testing unless explicitely said
#Default permissions are:
#1100NTS - Support user
#AD43999 - Client Admin
#PS12999 - Client Admin
#MRIQWEB - Client Admin
#P123456 - Client Admin


#Scenario 1, 10, 19#
#These tests are repeated with clients PS12999, AD43999, and 1100NTS
Given I am logged in to the AIG Dev Environment (https://dev-mriagorainsights.redmz.mrisoftware.com/) with clientid MRIQWEB on an account with SysAdmin permissions and access to [ClientId] 
And in PowerBi clicking the ellipsis beside my username, settings, Manage connections and gateways
And I rename the dev_datalake and dev_datawarehouse that is not mriqweb, to [ClientId]_dev_datalake and [ClientId]_dev_datawarehouse
When in AIG I click my username at the bottom right and click Select a different ClientId
And I select, or manually enter [ClientId], click Select, and agree to onboard the new client
And click the Administration gear on the left panel, select User security settings
And click Add User at the top right, and add an account that has access to [ClientId] but does not have SysAdmin
And I click the username, click Permissions 
Then their permission should be the [ClientID] default

#Scenario 2, 11, 20#
When I click the [ClientId] default, and save
Then that access should be removed

#Scenario 3, 12, 21#
When I click the default again, and save
Then that access should be added

#Scenario 4, 13, 22#
When I click Add User at the top right, and add an account that has access to [ClientId] and Support User as a global role
And I click the username, click Permissions 
Then their permission should be the [ClientID] default

#Scenario 5, 14, 23#
When I click the [ClientId] default, and save
Then that access should be removed

#Scenario 6, 15, 24#
When I click the default again, and save
Then that access should be added

#Scenario 7, 16, 25#
When I click Support User, and save
Then that access should be removed

#Scenario 8, 17, 26#
When I click Support User again, and save
Then that access should be added

And log out of AIG

#Scenario 9, 18, 27#
When I go to https://welcome-release.redmz.mrisoftware.com/ and login to [ClientId] with a different account with access
And click the Administration gear on the left panel, select User security settings
And click Add User at the top right, and add an account that has access to [ClientId] but does not have SysAdmin
And I click the username, click Permissions 
Then their permission should be the [ClientID] default

And log out of AIG

#Now delete the records of the client#

When logged into the Azure Query Editor for the Dev AIG (https://portal.azure.com/#@MRISOFTWARE.onmicrosoft.com/resource/subscriptions/c398eb55-b057-45f9-8fe3-cfb0034418f5/resourceGroups/rg-dev-aig-eastus/providers/Microsoft.Sql/servers/mridevaig01eastus/databases/mridevaig01/queryEditor) mridevaig01 when I run Clear Tenant Data.sql (available through GitHub, or request from team member if unable to access GitHub) with the [ClientId]
And then run SELECT FROM [dbo].[IdentityPrincipal] WHERE Name = '[ClientId]'
Then it should return no lines

When I run SELECT FROM [dbo].[OrganisationWorkspace] WHERE TenantKey = '[ClientId]'
Then It should return no lines

When I run SELECT FROM [dbo].[PbiOrganisationWorkspace] WHERE TenantKey = '[ClientId]'
Then It should return no lines

#This confirms client is deleted from database#

When in PowerBi and I click Workspaces at the bottom left, 
And I find dev_[ClientId]_reports,  dev_[ClientId]_database, and  dev_[ClientId]_version, and delete all three
Then they should not appear in workspaces

#This confirms they are deleted from PowerBi

#Repeat with other [CliendId]s 

#Scenario 28, 29, 30#
Given I'm in Postman and MRI DSG - dev is selected at the top right
When I click Environments on the left side, click MRI DSG - dev
And change the Current value for impersonatingClientId and deployClientId to [ClientId] and click save
And click Collections at the top left, MRI DSG - dev, Non-Proxied, System Ops
And I click Authorization, scroll down, Get new access token, and login with a userid with full access and permission, and select that token
When I click CreateSystemAdmin, and send
And wait half an hour
When in the Azure query editor enter SELECT FROM [dbo].[IdentityPrincipal] WHERE Name = '[ClientId]'
And scroll all the way to the right to see the DefaultRoleId
Then the DefaultRoleId should match the intended default ClientId role
#Support User 8fc436d8-9d8f-45c3-b725-24e018d1e46d
#Client Admin 0bf31d96-ba94-461b-8d23-2cf99a70666c

When logged into the Azure Query Editor for the Dev AIG (https://portal.azure.com/#@MRISOFTWARE.onmicrosoft.com/resource/subscriptions/c398eb55-b057-45f9-8fe3-cfb0034418f5/resourceGroups/rg-dev-aig-eastus/providers/Microsoft.Sql/servers/mridevaig01eastus/databases/mridevaig01/queryEditor) mridevaig01 when I run Clear Tenant Data.sql (available through GitHub, or request from team member if unable to access GitHub) with the [ClientId]
And then run SELECT FROM [dbo].[IdentityPrincipal] WHERE Name = '[ClientId]'
Then it should return no lines

When I run SELECT FROM [dbo].[OrganisationWorkspace] WHERE TenantKey = '[ClientId]'
Then It should return no lines

When I run SELECT FROM [dbo].[PbiOrganisationWorkspace] WHERE TenantKey = '[ClientId]'
Then It should return no lines

#This confirms client is deleted from database#

When in PowerBi and I click Workspaces at the bottom left, 
And I find dev_[ClientId]_reports,  dev_[ClientId]_database, and  dev_[ClientId]_version, and delete all three
Then they should not appear in workspaces
#Repeat with the other ClientIds

#Here ClientId is MRIQWEB and P123456
When in the Azure query editor enter SELECT FROM [dbo].[IdentityPrincipal] WHERE Name = '[ClientId]'
And scroll all the way to the right to see the DefaultRoleId
Then the DefaultRoleId should match the intended default ClientId role
#Support User 8fc436d8-9d8f-45c3-b725-24e018d1e46d
#Client Admin 0bf31d96-ba94-461b-8d23-2cf99a70666c