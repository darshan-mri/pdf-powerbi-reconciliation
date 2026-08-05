Feature: Key Value Pair Query

  Scenario: Verify query is not deleted when deletion is cancelled

    Given the user logged in as Admin
    And the user is in the "Key Value Pair Query" Page
    And a user record exists in the table
    When the user clicks on the "Delete" icon for a specific query
    Then a confirmation popup should be displayed along with "delete" and "cancel" option
    When the user clicks on the "Cancel" button
    Then the confirmation popup should be closed
    And the Query along with Client Name should still exist in the table
    And no changes should be made to the query data