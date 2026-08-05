Scenario: Create and save a new Key Value Pair query
  Given I am on the Key Value Pair page
  When I click the "Add" button
  And I fill in the required query details
  And I click the "Execute" button
  And I click the "Save" button
  Then the query should be saved successfully
  And I should be redirected to the Key Value Pair home page
  And the newly saved query should be visible in the grid
  And no error message should be displayed