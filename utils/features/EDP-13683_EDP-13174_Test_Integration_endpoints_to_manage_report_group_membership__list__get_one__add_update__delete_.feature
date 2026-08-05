Scenario: Get all members of a report group


When I send a GET request api/internal/reportgroups/{groupIdOrName}/members with a groupname
(MRI AIG Integration -> Integration API -> Report Groups Membership -> Get List By Group Name - default page size )
Then the response status should be 200 and the response body should be a list of memberships containing with groupId, groupName, userId, userName

When I send a GET request api/internal/reportgroups/{groupIdOrName}/members with a groupid
(MRI AIG Integration -> Integration API -> Report Groups Membership -> Get List By Group Id - default page size )
Then the response status should be 200 and the response body should be a list of memberships containing with groupId, groupName, userId, userName

When I send the same GET request with an invalid groupname
Then the response status should be 404 and the group isn't found

Scenario: Get a specific report group member by username

When I send a GET request api/internal/reportgroups/TestTemp/members/testuser1 (MRI AIG Integration -> Integration API -> Report Groups Membership -> Get - By Group Id & User Name)
Then the response status should be 200 and the response body should be a list containing with groupId, groupName, userId, userName

When I send a GET request api/internal/reportgroups/TestTemp/members/{userid} (MRI AIG Integration -> Integration API -> Report Groups Membersship -> Get - By Group Id & User Id)
Then the response status should be 200 and the response body should be a list containing with groupId, groupName, userId, userName

When I send a GET request api/internal/reportgroups/TestTemp/members/{userid} using an invalid reportgroupname  (MRI AIG Integration -> Integration API -> Report Groups -> Members -> Get - By Group Id & User Id)
Then the response status should be 404 and the group isn't found

When I send the same GET request with a valid groupname and invalid username api/internal/reportgroups/TestTemp/members/nonexistentUser
Then the response status should be 404 and the error detail message should specify that the user was not found

Scenario: Add a user to a report group using POST


When I send a POST request api/internal/reportgroups/{groupIdOrName}/members/{usernameOrId} with a valid username and a reportgroup they are not a part of
(MRI AIG Integration -> Integration API -> Report Groups Membership -> Post Create - By Group Id & User Id)
Then the response status should be 201 and groupid, groupname, userid, and username will show in the body

When I send the same POST request again
Then the response status should be 409 stating the usermembership already exists

When I send the same POST request api/internal/reportgroups/nonexistentGroup/members/testuser1 with a nonexistentgroup and a valid user
Then the response status should be 404 and the error detail message should specify that the group was not found

When I send the same POST request api/internal/reportgroups/TestTemp/members/nonexistentUser with a valid group and invalid user
Then the response status should be 404 and the error detail message should specify that the user was not found


Scenario: Upsert a report group member using PUT (new membership)

Given a report group exists
And a user exists but is not a member of the group
When I send a PUT request
api/internal/reportgroups/{groupIdOrName}/members/{usernameOrId}
(MRI AIG Integration -> Integration API -> Report Groups Membership -> Put Upsert - By Group Id & User Id)
Then the response status should be 201


Scenario: Upsert a report group member using PUT (membership already exists)

Given a report group exists
And a user already belongs to that group
When I send the PUT request again
Then the response status should be 204


Scenario: Delete a report group member

When I send a DELETE request api/internal/reportgroups/{groupIdOrName}/members/{usernameOrId} (MRI AIG Integration -> Integration API -> Report Groups Membership -> Delete - By Group Id & User Id)
Then the response status should be 200 and the user should be removed as confirmed by the portal

When I send a DELETE request api/internal/reportgroups/nonexistentGroup/members/testuser1 with an invalid group and valid user
Then the response status should be 404 and the error detail message should specify that the group was not found

When I send a DELETE request api/internal/reportgroups/TestTemp/members/nonexistentUser with a nonexistent user (note: not a user that exists, but isn't part of the group, user cannot be in the system)
Then the response status should be 404 and the error detail message should specify that the user was not found


Scenario: Replace report group members when incremental is false

When I send a GET request {{baseUrl}}/api/internal/reportgroups/Group A/members (MRI AIG Integration->Integration API->Report Groups Membership-> List By Group Name - default page size)
And copy the results with all the existing members
And make sure there is a user I can remove, if not add one via the portal.
#Note: Make sure to have the list from above as without it you can accidently remove all users
When I send a PUT request
api/internal/reportgroups/{groupIdOrName}/members?incremental=false (MRI AIG Integration->Integration API->Report Groups Membership-> Bulk Upsert - By Group Name & Incremental false)
And the body tab contains the desired users listed as such ["user1@user.com", "user2@user.com", "user3@user.com"]
Then the response status should be 204 and only members of the report group should be the users listed above (confirm via portal or List By Group Name - default page size )


Scenario: Incrementally update report group members


When I send a PUT request
api/internal/reportgroups/{groupIdOrName}/members?incremental=true (MRI AIG Integration->Integration API->Report Groups Membership-> Bulk Upsert - By Group Name & Incremental false) ensuring to change =false to =true
And the body tab contains the desired users listed as such ["user1@user.com", "user2@user.com", "user3@user.com"]
Then the response status should be 204 and the users from the body should now be members along with any previously existing group members