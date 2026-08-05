Feature: Financial Hub Map Report

  Scenario: Update values based on Entity ID filter
    Given the user logs into PowerBI
    And the user opens the Financial Hub Map report from the workspace
    When the user selects the Entity ID filter from the filters pane
    Then the values for key cards, Hub Map, and Hub Map Details table should update according to the selected Entity ID filter