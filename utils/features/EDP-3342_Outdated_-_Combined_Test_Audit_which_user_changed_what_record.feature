##Note: This can be redone as several tests check user audits, most if not all these scenarios can be wrapped into them

Scenario: on-board system admin (user does not exist in the db)
Given I have NOT been already on-boarded to any client, 
When I run the postman request to on-board myself as a sys admin, 
Then all records created in the database as part of the on-boarding should have a LastUpdatedBy value set to the value of my IdentityPrincipal.Id in the db and a LastUpdatedDate set to the UTC value of the server at the time the records were written

Scenario: on-board system admin (user already exists in the db)
Given I have been already on-boarded to a client, 
When I run the postman request to on-board myself as a sys admin,
Then all records created in the database as part of the on-boarding should have a LastUpdatedBy value set to the value of my IdentityPrincipal.Id in the db and a LastUpdatedDate set to the UTC value of the server at the time the records were written

Scenario: on-board a non-sysadmin user (user does not exist in the db)
Given I have NOT been already on-boarded to any client, 
When I on-board by logging in to the AIG portal,
Then all records created in the database as part of the on-boarding should have a LastUpdatedBy value set to the value of my IdentityPrincipal.Id in the db and a LastUpdatedDate set to the UTC value of the server at the time the records were written

Scenario: on-board non-sysadmin (user already exists in the db)
Given I have been already on-boarded to another client, 
When I on-board by logging in to the AIG portal using a client id I’m not already on-boarded to,
Then all records created in the database as part of the on-boarding should have a LastUpdatedBy value set to the value of my IdentityPrincipal.Id in the db and a LastUpdatedDate set to the UTC value of the server at the time the records were written

Scenario: on-board client
Given the client is not already on-boarded,
When I on-board the client using the AIG portal to switch to the client id that is not yet on-boarded,
Then all records created in the database as part of the on-boarding should have a LastUpdatedBy value set to the value of my IdentityPrincipal.Id in the db and a LastUpdatedDate set to the UTC value of the server at the time the records were written

Scenario: report deployment
Given the client is already on-boarded,
When I run the postman request to deploy reports,
Then all records created in the database as part of the on-boarding should have a LastUpdatedBy value set to the value of my IdentityPrincipal.Id in the db and a LastUpdatedDate set to the UTC value of the server at the time the records were written

Scenario: report backup
Given I’ve made a change to a report,
When I save the change,
Then all records created in the database as part of the on-boarding should have a LastUpdatedBy value set to the value of my IdentityPrincipal.Id in the db and a LastUpdatedDate set to the UTC value of the server at the time the records were written

Scenario: switch to a client and make changes
Given I’m in the AIG portal and signed in with a user who can switch to another client,
When I switch to another client, and make changes like adding a Group (etc),
Then all records created in the database as part of the on-boarding should have a LastUpdatedBy value set to the value of my IdentityPrincipal.Id in the db and a LastUpdatedDate set to the UTC value of the server at the time the records were written