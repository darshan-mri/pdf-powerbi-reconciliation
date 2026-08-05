Feature: User Management - Duplicate Prevention

  Scenario: Prevent duplicate user creation on multiple rapid save clicks

    Given the user is on the "User Management" page
    And the "Create New User" panel is open
    And valid user details are entered
    And the "Save" button is enabled
    When the user clicks on the "Save" button multiple times rapidly
    Then only one user record should be created
    And the user should appear only once in the User Management table
    And no duplicate entries should exist for the same email