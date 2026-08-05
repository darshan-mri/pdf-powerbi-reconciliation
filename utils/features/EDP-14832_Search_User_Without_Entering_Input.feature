Feature: User Management - Search Functionality

  Scenario: Verify behavior when searching without entering input

    Given the user is on the "User Management" page

    When the user clicks on the "Search for User" field
    And leaves the field empty
    Then no search suggestions should be displayed
    And the user table should display all available records
    When the user presses "Enter" search without input
    Then the user table should remain unchanged
    And Valid error message should be displayed saying "please enter the mail id"
    And the pagination buttons should be enabled