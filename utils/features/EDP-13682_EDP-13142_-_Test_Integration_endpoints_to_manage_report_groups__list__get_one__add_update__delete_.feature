Feature: Report Groups API

Given I have postman open and select the correct INT environment from the upper right
And checked the secret to ensure it is correct
When I click the MRI AIG Integration collection in the left frame
And click the Authorization tab, and Get New Access Token at the bottom
Then the response should say it is authorized

Scenario: Get all report groups
When I send a GET request api/internal/reportgroups (MRI AIG Integration->Integration API->Report Groups->Get List - default page size)
Then the response status should be 200
And the response body should be a list of report groups with ID, name, and memberIds

Scenario: Get a specific report group by id or name
Given a report group exists with a name "TestTemp"
When I send a GET request api/internal/reportgroups/{groupIdOrName} (Get Get - By Name) use groupIdOrName TestTemp (or another)
Then the response status should be 200
And the response body should contain the group ID, group name, and memberIds

When I send the GET request request api/internal/reportgroups/{groupIdOrName} with the above reportgroup's group ID (Get Get - By Name) (part of the response from the above)
Then the response status should be 200
And the response body should contain the group ID, group name, and memberIds

Scenario: Get a report group that does not exist
When I send a GET request to "/reportgroups/nonexistentGroup"
Then the response status should be 404

Scenario: Create a new report group
When I send a POST request api/internal/reportgroups/{groupIdOrName} (MRI AIG Integration->Integration API->Report Groups-> Post Create by Name) with a new reportgroup name
Then the response status should be 201

When I send the same POST request as above, with the same existing report group
Then the response status should be 409

Scenario: Create a new report group using PUT
When I send a PUT request api/internal/reportgroups/{groupIdOrName} (MRI AIG Integration->Integration API->Report Groups-> Put Upsert by Id) with the new report group name as {groupIdOrName}, it should also appear in the body tab, if there is an 'id' value remove it. This is only used when you somehow have a GUID for the report group /before/ creating it. You might not have the ID to do such 
Then the response status should be 201


Scenario: Delete an existing report group
When I send a DELETE api/internal/reportgroups/{groupIdOrName} using an reportgroupid (MRI AIG Integration->Integration API->Report Groups-> Del Delete by Id)
Then the response status should be 200 and the group has been deleted (confirm in portal)

When I send a DELETE api/internal/reportgroups/{groupIdOrName} using a groupname (MRI AIG Integration->Integration API->Report Groups-> Del Delete by Name)
Then the response status should be 200

When I resend the Delete request after the previous step
Then the response status should be 404 stating the group does not exist


Scenario: Replace report groups when incremental is false
When I send a GET request {{baseUrl}}/api/internal/reportgroups (MRI AIG Integration->Integration API->Report Groups-> List - default page size)
And copy the results with all the existing report groups 
And make sure there is a group I can delete, if not add one via the portal.
#Note: Make sure to have the list from above as without it you can accidently delete all the groups
When I send a PUT request {{baseUrl}}/api/internal/reportgroups?incremental=false (MRI AIG Integration->Integration API->Report Groups->Bulk Upsert - Incremental False) with the body tab listed as ["testtemp1","testtemp2","testtemp3"] using the full list of report groups from above, except for the one to be deleted
Then the response status should be 204
And all the report groups should remain, except for the excluded report group which has been deleted.

Scenario: Incrementally update report groups

When I send a PUT request {{baseUrl}}/api/internal/reportgroups?incremental=true (MRI AIG Integration->Integration API->Report Groups->Bulk Upsert - Incremental False) making sure to set incremental=false to incremental=true with the body tab listed as ["testtemp1","testtemp2","testtemp3"] the list being whatever groups are to be added
Then the response status should be 204 and the groups listed in the body should exist as well as any previously existing groups


Scenario: Get all report groups for a user
When I send a GET request api/internal/users/appusers/{usernameOrId}/reportgroups with a valid username (MRI AIG Integration->Integration API->Report Groups-> Get Get by User name)
Then the response status should be 200
And the response body should be a list of report groups the user is a part of, as well as name and memberids

When I send a GET request api/internal/users/appusers/{usernameOrId}/reportgroups with a valid userid (MRI AIG Integration->Integration API->Report Groups-> Get Get by User Id)
Then the response status should be 200
And the response body should be a list of report groups the user is a part of, as well as name and memberids

Scenario: Get report groups for a user that does not exist
When I send a GET request api/internal/users/appusers/{usernameOrId}/reportgroups with a non-existant username (MRI AIG Integration->Integration API->Report Groups-> Get Get by Username)
Then the response status should be 404 and mention the user isn't found 

Scenario: Get a specific report group for a user
When I send a GET request api/internal/users/appusers/{usernameOrId}/reportgroups/{groupIdOrName} using a valid username and groupname (MRI AIG Integration->Integration API->Report Groups-> Get Get by User name and group name)
Then the response status should be 200
And the response body should contain the report group with ID name and users

When I send a GET request api/internal/users/appusers/{usernameOrId}/reportgroups/{groupIdOrName} using a valid userId and groupname (MRI AIG Integration->Integration API->Report Groups-> Get Get by User Id and group name)
Then the response status should be 200
And the response body should contain the report group with ID name and users


When I send a GET request api/internal/users/appusers/{usernameOrId}/reportgroups/{groupIdOrName} using a valid userId and a groupname they are not a part of (MRI AIG Integration->Integration API->Report Groups-> Get Get by User Id and group name)
Then the response status should be 404 and the error mention the group cannot be found

When I send a GET request api/internal/users/appusers/{usernameOrId}/reportgroups/{groupIdOrName} using a valid groupname and an invalid username (MRI AIG Integration->Integration API->Report Groups-> Get Get by User name and group name)
Then the response status should be 404 and the error mention the user cannot be found