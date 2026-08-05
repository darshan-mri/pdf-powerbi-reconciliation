Feature: User Interactions with Financial NOI Analysis Report

  Scenario: User opens a visual in Focus Mode
    Given User logs into PowerBI
    And User opens Financial NOI Analysis report from the workspace
    When User clicks the Focus Mode icon from the NOI by Entity chart or Revenue chart or OpEx chart or NOI Variance Breakdown table
    Then The visual should be displayed in full screen with the values intact
    And A back button should be visible to navigate back to the home page