Feature: Client Management

  Scenario: Verify Admin can delete the clients successfully

    Given the user logged in as Admin
    And the user is in the "client Management" page
    And a client record exists in the table
    When the user clicks on the "Delete" icon for a specific client
    Then a confirmation popup should be displayed
    And the popup should contain "Delete" and "Cancel" options
    When the user clicks on the "Delete" button
    Then a loading indicator should be displayed
    And the user should be removed from the table
    And the user should not appear in search results