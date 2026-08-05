Feature: Financial Details + Group By Filter Interaction

  Scenario: User selects the Group By filter and sees updated visuals in the Blended Forecast Details table
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    When User selects Group By filter from the Filters pane
    Then The visuals should be updated and values of the Blended Forecast Details table should be displayed according to the selected Group By filter