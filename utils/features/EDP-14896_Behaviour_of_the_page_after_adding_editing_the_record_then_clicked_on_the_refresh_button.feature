Feature: Client Management Page

  Scenario: Verify page behavior after a user is added or edited

    Given the user is logged in as Admin
    And the user is on the "Client Management" page
    When the user adds a new client or edits an existing client
    And the user clicks on the "Refresh" button
   Then the edited functionality should be displayed in the client record