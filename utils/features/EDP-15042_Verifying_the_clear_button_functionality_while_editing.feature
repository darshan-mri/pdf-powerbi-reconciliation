Feature:Query connector
  Scenario:Verifying the clear button functionality while editing
    
    Given the user logged in as admin
    And the user is in the "Query connector page"
    When the user clicks on the "Edit icon"
    Then the "Edit Connector" side panel should be displayed
    When the user edits any of the options 
    And clicks on the "Clear" Button 
    Then all the data must be cleared 
    And all the fields should be empty
    And "Data cleared" message should be displayed