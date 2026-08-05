Feature:Key Value Pair Query
  
  Scenario:verification of the mandatory fields
    
    Given the user logged in as Admin
    And the user is in the "Key Value Pair" Page
    When the user clicks on the "+Add"
    Then the "New Query" side panel should be displayed
    When the user does not write any query in the text box 
    And directly navigates to the execute button 
    Then the error message should be displayes"this field is required"
    And the execute button should be disabled