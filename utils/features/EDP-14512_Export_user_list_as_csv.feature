Feature: Export Users - Download All

Background:
Given I am logged into Dev https://dev-mriagorainsights.redmz.mrisoftware.com/ as a System Admin with any client ID
And I navigate to Admin Settings
And I open User Security Settings

Scenario 1: Successful export of all users
When I open the action menu
And I select "Download All"
Then a CSV containing all users in scope should be downloaded(Location will be local Downloads folder)
And the action menu should close
And "Download All" should show "progressing" and remain disabled until the export completes
Then verify by opening the downloaded csv and check the users and roles,groups for that clientID

Scenario 2: Export ignores applied filters
Given filters are applied to the users list
When I open the action menu
And I select "Download All"
Then the exported CSV should contain all users in scope
And the applied filters should be ignored

Scenario 3: Export includes groups and roles
Given users have group if not create group with any name in dashboard access
When I select "Download All"
Then the CSV should include Groups and Roles for each user

Scenario 4: Export failure handling
When I select "Download All" and the export request fails(can do this via failing the network)
Then a failure toast notification should be displayed
And "Download All" should be enabled again

Scenario 5: Feature flag disabled
Given the export users feature flag is disabled in app configuration("https://portal.azure.com/#@MRISOFTWARE.onmicrosoft.com/resource/subscriptions/4c98c256-bc60-40ba-8bcb-81ae94ac52d4/resourceGroups/rg-shared-aig-eastus/providers/Microsoft.AppConfiguration/configurationStores/appcs-aig-dev/ff")
When I paste the url in browser and search for usercsvexport if its enabled, disable it.
Then switch back to portal then "Download All" should be disabled
And the menu text should include "unavailable"

Scenario 6: No users to export
Given there are no users in scope
When I select "Download All"
Then a headers-only CSV file should be downloaded

Scenario 7: Export already in progress
Given an export is already in progress(can do this via, Ctrl+Shift+C go to Network tab select 3G from dropdown)
When I open the action menu
Then "Download All" should be disabled
And the menu text should include "progressing"()