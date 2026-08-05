Feature:Query connector
  Scenario: Edit user functionality
    
    Given the user logged in as Admin
    And the user is in the "Query connector" page
    When the user clicks on the "Edit" icon of any query connector
    Then the "Edit Connector" side panel should be displayed
    When the user edits any one of the following:
    | Name       |
    | Type       |
    | Status     |
    | Description|
    | Query      |
    | Input key  |
    And Clicks on execute
    Then if the edited value is valid 
    Then it should execute if the value is not valid
    Then the valid error message should be displayed
    When the user clicks on the Update button 
    Then the changed values should be displayed in the table