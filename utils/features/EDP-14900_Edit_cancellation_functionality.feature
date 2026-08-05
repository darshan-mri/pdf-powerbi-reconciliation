Feature: User Management - Edit User Functionality

  Scenario: Verify admin can edit user role successfully

    Given the user is on the "User Management" page
    And the logged-in user has "Admin" privileges
    And a user record exists in the table
    When the admin clicks on the "Edit" icon for a specific user
    Then the "Edit User" panel should be displayed
    And the existing user details should be pre-populated
    When the admin updates the "Role" field
    And clicks on the "Cancle" button
    Then the record should not be recorded in the table