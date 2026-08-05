Feature: Financial Hub Map + Entity Name Filter Interaction

  Scenario: User selects Entity Name filter from the filters pane
    Given User logs into PowerBI
    And User opens the Financial Hub Map report from the workspace
    When User selects Entity Name filter from the filters pane
    Then the values should be updated for key cards, Hub Map, and Hub Map Details table as per the selected Entity Name filter