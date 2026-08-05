Feature: Financial Hub Map + Basis Filter Interaction

  Scenario: Update values based on Basis filter selection
    Given User logs into PowerBI
    And User Opens Financial Hub Map report from the workspace
    When User selects Basis filter from the filters pane
    Then the values should be updated for key cards, Hub Map, and Hub Map Details table as per the selected Basis filter