Feature: Financial Details + Entity Name Filter Interaction

  Scenario: User selects the Entity Name filter and sees updated visuals in the Blended Forecast Details table
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    When User selects Entity Name filter from the Filters pane
    Then The visuals should be updated and values of the Blended Forecast Details table should be displayed according to the selected Entity Name filter