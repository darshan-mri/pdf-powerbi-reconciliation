Feature: Financial Details + Variance Type Filter Interaction

  Scenario: User selects the Variance Type filter and sees updated visuals
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    When User selects Variance Type filter from the Filters pane
    Then The visuals should be updated and values should be displayed in the report according to the selected Variance Type filter