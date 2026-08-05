Feature: Financial NOI Analysis Report

  Scenario: User applies filters with different combinations from the filter pane
    Given User logs into PowerBI
    And User opens Financial NOI Analysis report from the workspace
    When User applies filters with different combinations from the filter pane
    Then The visuals should be updated and values should be displayed according to the selected filters