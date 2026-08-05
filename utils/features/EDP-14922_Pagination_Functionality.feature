Feature: Key Value Pair Query

  Scenario: Verify pagination navigates to the next set of records

    Given the user logged in as Admin
    And the user is in the "Key Value Pair Query" Page
    And multiple user records exist across pages
    When the user clicks on the "Next" page button
    Then the next set of user records should be displayed
    When the user clicks on the "previous" page button
    Then the previous set of user record should be displayed
    And the current page number should be updated
    And the displayed records should be different from the previous page