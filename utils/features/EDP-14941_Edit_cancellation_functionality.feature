Feature: Key Value Pair Query

  Scenario: Verify admin can edit Query

    Given the user is on the "Key Value Pair Query" page
    And the logged-in user has "Admin" privileges
    And a query records exists in the table
    When the admin clicks on the "Edit" icon for a specific query 
    Then the "Edit query" panel should be displayed
    And the existing Query and  details should be pre-populated
    When the admin updates the Query field
    And clicks on the "Cancle" button
    Then the record should not be recorded in the table