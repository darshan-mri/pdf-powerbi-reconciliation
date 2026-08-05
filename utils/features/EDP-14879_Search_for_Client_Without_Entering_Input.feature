Feature: Client Management
  Scenario: Verify behavior when searching without entering input

    Given the user logged in as Admin
    And the user is in the "Client Management" page
    When the user clicks on the "Search for client" field
    And leaves the field empty
    Then no search suggestions should be displayed
    And the Client table should display all available records
    When the user presses "Enter" search without input
    Then the Client table should remain unchanged
    And Valid error message should be displayed saying "please enter the valid Client Id or Client Name"
    And the pagination buttons should be enabled