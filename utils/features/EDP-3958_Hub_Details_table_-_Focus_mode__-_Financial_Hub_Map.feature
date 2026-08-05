Feature: Financial Hub Map + Hub Details Table Focus Mode

  Scenario: User clicks on the Focus mode icon in Hub Details table
    Given User logs into PowerBI
    And User opens Financial Hub Map report from the workspace
    When User clicks on the Focus mode icon in Hub Details table
    Then The Hub Details table should be displayed in full screen with the values intact
    And The user should see a back button to navigate back to the home page