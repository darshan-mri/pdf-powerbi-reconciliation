Feature: Client Management
  Scenario: Verify client is not deleted when deletion is cancelled

    Given the user is logged in as the Admin
    And the user is in the "Client Management" page
    And a client record exists in the table
    When the user clicks on the "Delete" icon for a specific client
    Then a confirmation popup should be displayed
    When the user clicks on the "Cancel" button
    Then the confirmation popup should be closed
    And the user should still exist in the table
    And no changes should be made to the client data