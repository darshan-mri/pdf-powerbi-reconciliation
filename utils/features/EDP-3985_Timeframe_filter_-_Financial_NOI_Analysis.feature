Feature: User Interactions with Financial NOI Analysis Report

  Scenario: User selects a Timeframe filter from the filters pane
    Given User logs into PowerBI
    And User opens Financial NOI Analysis report from the workspace
    When User selects the Timeframe filter from the filters pane
    Then The values and visuals should be updated as per the selected Timeframe filter
    And The Titles of the visuals should be appended with the selected Timeframe filter