Feature:Query connector
  Scenario:Cancellation button functionality During edit process
    
    Given the user logged in as Admin
    And the user is in the "Query connector"page
    When the user clicks on the "+Add"
    Then the "Edit Query" side panel should be displayed
    When the user edit the query
    And clicks on the cancle button 
    Then the side panel should be closed
    And the edited query should not be saved