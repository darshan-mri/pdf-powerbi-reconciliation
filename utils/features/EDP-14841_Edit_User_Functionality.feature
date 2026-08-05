Feature: User Management - Edit User Functionality

  Scenario: Verify admin can edit user role successfully

    Given the user is on the "User Management" page
    And the logged-in user has "Admin" privileges
    And a user record exists in the table
    When the admin clicks on the "Edit" icon for a specific user
    Then the "Edit User" panel should be displayed
    And the existing user details should be pre-populated
    When the admin updates the "Role" field
    And clicks on the "Save" button
    Then a loading indicator should be displayed
    And the changes should be saved successfully
    And the updated role should be reflected in the user table
    And the "Modified User" should be updated to the current logged-in admin
    And the "Modified Date" should be updated with the latest timestamp