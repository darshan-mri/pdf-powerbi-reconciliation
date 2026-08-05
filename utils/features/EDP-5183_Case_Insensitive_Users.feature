Given I’m logged in as a role that can add other users

When I go to User Security Settings and click +Add User

And I put in the email address for an account assigned to the ClientID, but not yet a user ( aig.user4@mrisoftware.disabled / P123456)

Then regardless of placement or pattern of upper case letters AIG will find the correct email and allow creation of the user