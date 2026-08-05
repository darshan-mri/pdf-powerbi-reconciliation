Feature: Key Value Pair Query

  Scenario: Verify page behavior after a user is added or edited

    Given the user is logged in as Admin
    And the user is on the "Key Value Pair Query" page
    When the user adds a new Query or edits an existing Query
    And the user clicks on the "Refresh" button
    Then the edited/newly added query should be visible