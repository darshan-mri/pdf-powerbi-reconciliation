Feature: User Interactions with Financial NOI Analysis Report

  Scenario: User selects an Entity Name filter from the filters pane
    Given User logs into PowerBI
    And User opens Financial NOI Analysis report from the workspace
    When User selects the Entity Name filter from the filters pane
    Then The values and visuals should be updated as per the selected Entity Name filter