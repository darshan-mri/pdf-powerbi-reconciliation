Feature: Key Value Pair Query

  Scenario: Verify sorting functionality for different columns

    Given the user logged in as Admin
    And the user is in the "Key Value Pair" page
    And multiple client records exist in the table
    When the user clicks on the "<Column Name>" column header
    Then the user records should be sorted in ascending alphabetical order based on "<Column Name>"
    When the user clicks on the "<Column Name>" column header again
    Then the user records should be sorted in descending alphabetical order based on "<Column Name>"
    Examples:
      | Column Name     |
      | Client Name     |
      | Status          |
      | Modified User   |
      | Modified Date   |
    And sorting should be consistent across pagination