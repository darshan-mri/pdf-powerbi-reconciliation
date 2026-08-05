Feature: Key Value Pair Query

  Scenario: Verify no partial data is saved on page refresh during query creation
   
    Given the user logged in as Admin
    And the user is in the "Key Value Pair Query"
    When the user click on the "+Add" button
    And the " New Query" panel should be displayed
    And the user has entered partial query
    When the user refreshes the page
    Then no partial data should be saved
    And the user should be redirected to the "Key value Pair Query" page
    And the partially entered data should be cleared