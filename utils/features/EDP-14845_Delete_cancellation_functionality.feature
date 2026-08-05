Feature: User Management - Delete User Functionality

  Scenario: Verify user is not deleted when deletion is cancelled

    Given the user is on the "User Management" page
    And a user record exists in the table
    When the user clicks on the "Delete" icon for a specific user
    Then a confirmation popup should be displayed
    When the user clicks on the "Cancel" button
    Then the confirmation popup should be closed
    And the user should still exist in the table
    And no changes should be made to the user data