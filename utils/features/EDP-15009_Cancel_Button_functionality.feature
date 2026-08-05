Feature:Query Connector
  
  Scenario:Working of the cancel buttom
    
    Given the user logged in as Admin
    And the user is in the "Query connector"page
    When the user clicks on the "+Add" button 
    Then the "New Connector" side panel should be displayed
    When the user enters all the details
    Then click on the "Cancel" Button
    Then the "New Connector" side panel should be closed 
    And data should not be saved in the table