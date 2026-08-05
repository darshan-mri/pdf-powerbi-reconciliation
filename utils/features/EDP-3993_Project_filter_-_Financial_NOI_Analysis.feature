Feature: Financial NOI Analysis Report

  Scenario: User selects a Project filter from the filters pane
    Given User logs into PowerBI
    And User opens Financial NOI Analysis report from the workspace
    When User selects the Project filter from the filters pane
    Then The values and visuals should be updated as per the selected Project filter