Feature: Financial Hub Map + Period Filter Interaction

  Scenario: User selects Period filter from the filters pane
    Given User logs into PowerBI
    And User opens the Financial Hub Map report from the workspace
    When User selects Period filter from the filters pane
    Then the values should be updated as per the selected period filter