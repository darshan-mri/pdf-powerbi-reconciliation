Feature:Query Connector
  Scenario: verifying search functionality by giving the complete query
    
    Given the user logged in as Admin
    And the user is in the "Query Connector" page
    When the user clicks on the "search for query" textbox
    Then the textbox should be highlighted 
    And the cursor should be visible inside the textbox
    When the user types in the enitre query in the search box
    And click enter
    Then the valid error messgae should be displayed