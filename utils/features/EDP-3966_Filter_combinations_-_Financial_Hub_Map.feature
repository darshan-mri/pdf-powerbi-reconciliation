Feature: Financial Hub Map + Filter Combinations Interaction

  Scenario: Apply filters with different combinations and update visuals
    Given User logs into PowerBI
    And User Opens Financial Hub Map report from the workspace
    When User applies filters with different combinations from the filter pane
    Then the visuals should be updated and values should be displayed according to the selected filters