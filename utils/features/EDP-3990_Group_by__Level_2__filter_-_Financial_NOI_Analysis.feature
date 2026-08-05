Feature: User Interactions with Financial NOI Analysis Report

  Scenario: User selects a Group by (Level 2) filter from the filters pane
    Given User logs into PowerBI
    And User opens Financial NOI Analysis report from the workspace
    When User selects the Group by (Level 2) filter from the filters pane
    Then The values and visuals should be updated as per the selected Group by (Level 2) filter