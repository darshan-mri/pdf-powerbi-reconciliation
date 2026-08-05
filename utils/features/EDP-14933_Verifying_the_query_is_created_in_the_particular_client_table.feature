Feature: Key Value Pair Query
  
  Scenario: Verifying the query is created and update in the particular client record
    
    Given the user logged in as Admin 
    And the user is in the "Key Value Pair Query" Page
    When the user click on the "+Add" button
    Then the side panel "New Query" should be displayed
    And the user add or updates the required query
    Then it should be displayed in that particular client record
    When we change the client on the plugin side 
    Then the added query should not be present in the different client