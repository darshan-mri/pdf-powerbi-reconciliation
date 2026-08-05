Feature:Key Value Pair Query
  Scenario:Addition of the new query
    
    Given the user logged in as Admin 
    And the user is in the Key Value Pair Query
    When the user click on "+Add" button 
    Then the "New Query" side panel should open
    And that page should contain Query textbox
    When the user clicks on the "write your query"
    Then the Query textbox should be highlighted 
    And the cursor should be visible inside the textbox
    And user should be able to type the query inside the textbox
    When the query is typed then the execute button should be enabled
    And when the user click on the execute button 
    Then the record should be saved in the table 
    And  it should be only one query in Active status