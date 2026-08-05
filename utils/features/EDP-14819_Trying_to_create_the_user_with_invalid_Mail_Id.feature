Feature: User Management

  Scenario: Display validation error when entering an invalid email while adding a user

    Given the user is logged in as Admin
    And is in the "User Management" page
    When the user clicks on the "+ Add" button
    Then the "Create New User" side panel should be displayed
    When the user enters an invalid email address in the "Search User by Email" field
    Then a validation error message should be displayed
    And the error message should read "Please enter a valid email address"
    And no email suggestions should be displayed
    And user details fields should not be populated
    When the user clicks on the "Save" button
    Then the "Save" button should remain disabled
    And the user should not be added to the User Management list