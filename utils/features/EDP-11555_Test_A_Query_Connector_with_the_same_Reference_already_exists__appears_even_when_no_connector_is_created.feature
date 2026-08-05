Scenario: Create and save a new Query Connector with a unique Reference name
  Given I navigate to the Query Connector page
  When I click on the "Add" button
  And I enter all required details including a unique "Reference" name
  And I click the "Execute" button
  And I click the "Save" button
  Then the system should save the new Query Connector successfully
  And I should not see any error message
  And the newly created Query Connector should be visible in the grid