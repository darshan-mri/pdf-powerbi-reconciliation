Feature: User Management - Search Functionality

  Scenario: Verify no data is displayed when email is not found

    Given the user is on the "User Management" page

    When the user clicks on the "Search for User" field
    And enters a non-existing email address
    Then no matching suggestions should be displayed
    And the user table should display the message "No data available"
    And the table should show "0 - 0 of 0 items"
    And the pagination buttons should be disabled