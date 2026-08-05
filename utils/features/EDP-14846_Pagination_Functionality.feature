Feature: User Management - Pagination Functionality

  Scenario: Verify pagination navigates to the next set of records

    Given the user is on the "User Management" page
    And multiple user records exist across pages
    When the user clicks on the "Next" page button
    Then the next set of user records should be displayed
    When the user clicks on the "previous" page button
    Then the previous set of user record should be displayed
    And the current page number should be updated
    And the displayed records should be different from the previous page