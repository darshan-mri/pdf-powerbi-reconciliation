Feature:QUery Connector
  Scenario:Delete query functionality
    
    Given the user logged in as Admin
    And the user is in the "Query Connector"
    When the user clicks on the"+ADD" button
    Then the "Edit Query" side panel should be opened