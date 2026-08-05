Feature: Financial Hub Map + Focus Mode Interaction

  Scenario: User clicks on the Focus mode icon in Hub Map
    Given User logs into PowerBI
    And User opens Financial Hub Map report from the workspace
    When User clicks on the Focus mode icon in Hub Map
    Then The Hub Map should be displayed in full screen with the values intact
    And The user should see a back button to navigate back to the home page