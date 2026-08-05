Feature:User Management 
  Scenario:Verifying the suggestion display when clicked on the search button
    
    Given the user logged in as Admin
    And the user is in the "User Management" page
    When the user click on the "Search for the user" 
    Then the "Search for user" textbox should be highlighted
    And the cursor should be inside the textbox
    And some of the lastest search suggestions should be displayed in the suggestion list