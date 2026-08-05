Feature: Client Management

  Scenario: Verify no data is displayed when Clinet Id or Client name not found
   
    Given the user logged in as admin 
    And the user is in the "Client Management" page
    When the user clicks on the "Search for Client" field
    And enters a non-existing "Client Id" or "Client Name"
    Then no matching suggestions should be displayed
    And the Client table should display the message "No data available"
    And the table should show "0 - 0 of 0 items"
    And the pagination buttons should be disabled