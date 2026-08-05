Feature: Key Value Pair Query
  Scenario: Verify behavior when searching without entering input

    Given the user is on the "User Management" page

    When the user clicks on the "Search for key value pair query" field
    And leaves the field empty
    Then no search suggestions should be displayed
    And the query table should display all available records
    When the user presses "Enter" search without input
    Then the query table should remain unchanged
    And Valid error message should be displayed saying "please enter the client id"
    And the pagination buttons should be enabled