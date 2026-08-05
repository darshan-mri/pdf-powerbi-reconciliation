Feature: User Interactions with Financial NOI Analysis Report

  Scenario: User hovers over Filters icon to view applied filters
    Given User logs into PowerBI
    And User opens Financial NOI Analysis report from the workspace
    When User hovers over the Filters icon from the NOI by Entity chart or Revenue chart or OpEx chart or NOI Variance Breakdown table
    Then User should see the applied filters