Feature:Key Value Pair
  Scenario: Cancel button functionality
    
    Given the user logged in as Admin
    And the user is in the "Key Value Pair query" page
    When the user clicks on the "+Add" Button
    Then the "New Query" side panel should be displayed
    When the user click on the Write your query textbox 
    Then the field should be highlited 
    And the cursor should be inside the textbox
    When the user clicks on the cancel button with or without the query inside the textbox
    Then the "New Query" side panel should be closed
    And there should be no changes in the current record