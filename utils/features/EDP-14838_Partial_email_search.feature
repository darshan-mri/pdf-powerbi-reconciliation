Feature: User Management - Search Functionality

  Scenario: Verify behavior when searching with partial email

    Given the user is on the "User Management" page
    When the user clicks on the "Search for User" field
    And enters a partial email address
    Then matching email suggestions should be displayed
    And the suggestions should contain relevant users
    When the user selects a suggestion
    Then the user table should display matching user records
    And the displayed results should match the selected email