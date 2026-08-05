Scenario: Creating a new user shows success toaster
  Given I am on the User Management page
  When I create a new user and click "Save"
  Then a toaster message "User created successfully" should appear

Scenario: Updating a user shows success toaster
  Given I am on the User Management page
  When I edit an existing user and click "Save"
  Then a toaster message should appear indicating the user was updated successfully