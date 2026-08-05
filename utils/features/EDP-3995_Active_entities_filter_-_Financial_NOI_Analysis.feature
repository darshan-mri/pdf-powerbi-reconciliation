Feature: Financial NOI Analysis Report - Active Entities Filter

  Scenario: User selects an Active Entities filter from the filters pane
    Given User logs into PowerBI
    And User opens Financial NOI Analysis report from the workspace
    When User selects the Active Entities filter from the filters pane
    Then The values and visuals should be updated as per the selected Active Entities filter