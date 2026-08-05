Feature: Query Connector

  Scenario: Verify sorting functionality for different columns

    Given the user logged in as Admin
    And the user is in the "Query Connector" page
    And multiple user records exist in the table
    When the user clicks on the "<Column Name>" column header
    Then the user records should be sorted in ascending alphabetical order based on "<Column Name>"
    When the user clicks on the "<Column Name>" column header again
    Then the user records should be sorted in descending alphabetical order based on "<Column Name>"
    Examples:
      | Column Name     |
      | Name            |
      | Status          |
      | Input Key Name  |
      | Modified User   |
      | Modified Date   |
      | Actions         |
    And sorting should be consistent across pagination