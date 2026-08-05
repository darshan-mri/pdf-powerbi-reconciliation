Feature: Query Connector
  Scenario:Verification of the update button
    
    Given the user logged in as Admin
    And the user is in the "Query Connector" page
    When the user clicks on the "edit icon"
    Then the "Edit connector" side panel should be displayed
    When the user edit the query 
    And click on the "execute" button 
    Then the query should be executed
    And Once the query is executed
    Then only the update button should be visible
    And once the user clicks on the "Update" button 
    Then the modified field should be saved