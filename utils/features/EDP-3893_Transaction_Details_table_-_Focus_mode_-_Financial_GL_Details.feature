Feature: Financial GL Details Report Focus Mode Feature

  Scenario: Ensure Transaction Details table works in Focus mode
    Given User logs into PowerBI
    And User opens Financial GL Details report from the workspace
    When User clicks on Focus mode for the Transaction Details table
    Then the Transaction Details table should be displayed in full screen with the values intact
    And there should be a back button to navigate back to the home page