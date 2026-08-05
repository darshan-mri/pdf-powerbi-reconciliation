Feature:Key Value Pair
  Scenario: clear button functionality
    
    Given the user logged in as Admin
    And the user is in the "Key Value Pair query" page
    When the user clicks on the "+Add" Button
    Then the "New Query" side panel should be displayed
    When the user click on the Write your query textbox 
    Then the field should be highlited 
    And the cursor should be inside the textbox
    When the user clicks on the clear button without any query inside the textbox
    Then the valid message should be displayed like"the field is empty"