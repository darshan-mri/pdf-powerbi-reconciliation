Feature: Query Connector

  Scenario: Verify no data is displayed when query is not found

    Given the user logged in as Admin
    And the user is the "Query Connector" page
    When the user clicks on the "Search for query" field
    And enters a query name
    Then no matching suggestions should be displayed
    And the table should display the message "No data available"
    And the table should show "0 - 0 of 0 items"
    And the pagination buttons should be disabled