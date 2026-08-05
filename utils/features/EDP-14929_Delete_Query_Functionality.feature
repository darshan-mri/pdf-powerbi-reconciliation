Feature: Key Value Pair Query

  Scenario: Verify Query can be deleted successfully

    Given the user logged in as Admin
    And the user is in the "Key Value Pair Query" page
    And a query record exists in the table
    When the user clicks on the "Delete" icon for a specific query
    Then a confirmation popup should be displayed
    And the popup should contain "Delete" and "Cancel" options
    When the user clicks on the "Delete" button
    Then a loading indicator should be displayed
    And the query should be removed from the table
    And the query along with  Client Name should not appear in search results
    And also it should not appear in the records