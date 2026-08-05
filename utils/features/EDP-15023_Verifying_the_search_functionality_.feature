Feature: Query Connector
  Scenario:Verifying the search functionality
    
    Given the user logged in as Admin
    And the user is in the "Query Connector" Page
    When the user clicks on the "Search for Query connector" textbox 
    Then the textbox should be highlighted
    And the cursor should be inside the textbox
    When the user search for the required query by name
    Then the suggestion must appear based on the search