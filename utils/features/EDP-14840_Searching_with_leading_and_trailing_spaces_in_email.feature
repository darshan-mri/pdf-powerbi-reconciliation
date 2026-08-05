Feature: User Management - Search Functionality

  Scenario: Verify behavior when searching with leading and trailing spaces in email

    Given the user is on the "User Management" page

    When the user clicks on the "Search for User" field
    And enters an email address with leading and trailing spaces
    Then the system should trim the spaces
    And matching email suggestions should be displayed
    When the user selects a suggestion
    Then the user table should display matching user records
    And the displayed results should match the trimmed email