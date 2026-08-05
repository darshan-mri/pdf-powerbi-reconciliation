Feature: Client Management

  Scenario: Verify admin can edit customer role successfully

    Given the user is on the "Client Management" page
    And the logged-in user has "Admin" privileges
    And a client record exists in the table
    When the admin clicks on the "Edit" icon for a specific client
    Then the "Edit client" panel should be displayed
    And the existing client details should be pre-populated
    When the admin updates the "Role" field
    And clicks on the "Cancle" button
    Then the record should not be recorded in the table