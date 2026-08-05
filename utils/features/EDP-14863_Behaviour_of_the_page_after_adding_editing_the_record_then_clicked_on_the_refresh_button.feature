Feature: User Management Page

  Scenario: Verify page behavior after a user is added or edited

    Given the user is logged in as Admin
    And the user is on the "User Management" page
    When the user adds a new user or edits an existing user
    And the user clicks on the "Refresh" button
    Then only the features accessible to the assigned role should be visible
    And the record should be displayed in the appropriate table based on its role