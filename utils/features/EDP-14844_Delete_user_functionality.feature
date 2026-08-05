Feature: User Management - Delete User Functionality

  Scenario: Verify user can be deleted successfully

    Given the user is on the "User Management" page
    And a user record exists in the table
    When the user clicks on the "Delete" icon for a specific user
    Then a confirmation popup should be displayed
    And the popup should contain "Delete" and "Cancel" options
    When the user clicks on the "Delete" button
    Then a loading indicator should be displayed
    And the user should be removed from the table
    And the user should not appear in search results