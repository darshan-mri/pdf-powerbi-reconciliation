Feature: Key Value Pair Query

  Scenario: Verify no data is displayed when client id or name is not found

    Given the user is on the "Key Value pair query" page

    When the user clicks on the "Search for key value pair query" field
    And enters a non-existing client name or client id
    Then no matching suggestions should be displayed
    And the query table should display the message "No data available"
    And the table should show "0 - 0 of 0 items"
    And the pagination buttons should be disabled