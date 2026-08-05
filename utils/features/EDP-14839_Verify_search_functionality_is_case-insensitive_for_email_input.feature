Feature: User Management - Search Functionality

  Scenario: Verify behavior when searching with different email case formats

    Given the user is on the "User Management" page

    When the user clicks on the "Search for User" field
    And enters an email address in different case format
    Then matching email suggestions should be displayed
    And the suggestions should contain the correct user
    When the user selects a suggestion
    Then the user table should display matching user records
    And the displayed results should match the entered email irrespective of case
    And if there is no record avaliable then "No data avaliable" message should be displayed