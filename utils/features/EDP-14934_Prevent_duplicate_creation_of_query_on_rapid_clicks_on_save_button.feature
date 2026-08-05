Feature: Key Value Pair Query 

  Scenario: Prevent duplicate query creation on multiple rapid save clicks

    Given the user logged in as Admin 
    And the user is in the "Key Value Pair Query" Page
    When the user clicks on the "+Add"
    Then "New Query" panel is displayed
    And valid query is entered
    And the "Save" button is enabled
    When the user clicks on the "Save" button multiple times rapidly
    Then only one query respect to that client record should be created
    And the Client name should appear only once in the Key Value Pair Query table
    And no duplicate entries should exist for the same Cilent