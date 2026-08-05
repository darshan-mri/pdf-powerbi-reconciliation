Feature:Query Connector
  
  Scenario:Behaviour of the clear button
    
    Given the user logged in as Admin 
    And the user is in the "Query Connector" page
    When the user click on the "+Add" button 
    Then the "New Connector" side panel should be displayed
    When the user enters all the data 
    And clicks on the clear button 
    Then all the entered data should be cleared 
    And all the fields must be empty 
    And a message should be displayed "Data cleared successfully"
    And the new query connector should not be displayed in the record