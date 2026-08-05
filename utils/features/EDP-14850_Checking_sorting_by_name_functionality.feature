Feature: User Management - Sorting Functionality

  Scenario: Verify sorting functionality for different columns

    Given the user is on the "User Management" page
    And multiple user records exist in the table
    When the user clicks on the "<Column Name>" column header
    Then the user records should be sorted in ascending alphabetical order based on "<Column Name>"
    When the user clicks on the "<Column Name>" column header again
    Then the user records should be sorted in descending alphabetical order based on "<Column Name>"
    Examples:
      | Column Name     |
      | First Name      |
      | Last Name       |
      | Modified User   |
    And sorting should be consistent across pagination