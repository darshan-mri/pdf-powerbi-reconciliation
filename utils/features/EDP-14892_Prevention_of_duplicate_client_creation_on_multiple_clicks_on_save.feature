Feature: Client Management

  Scenario: Prevent duplicate client creation on multiple rapid save clicks

    Given the user logged in as Admin
    And the user is in the "Client Management"
    When the user clicks on the "+Add" button 
    And the "Create New Client" panel is open
    And valid user details are entered
    And the "Save" button is enabled
    When the user clicks on the "Save" button multiple times rapidly
    Then only one Client record should be created
    And the client should appear only once in the User Management table
    And no duplicate entries should exist for the same client