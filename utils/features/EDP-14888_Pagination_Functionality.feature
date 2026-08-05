Feature:Client Management
  
  Scenario: Verify pagination navigates to the next set of records

    Given the user logged in as Admin
    And the user is in the "Client Management"page
    And multiple client records exist across pages
    When the user clicks on the "Next" page button
    Then the next set of client records should be displayed
    When the user clicks on the "previous" page button
    Then the previous set of client record should be displayed
    And the current page number should be updated
    And the displayed records should be different from the previous page