Feature: Financial Details + Period Filter Interaction

  Scenario: User selects the Period filter and sees updated visuals
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    When User selects Period filter from the Filters pane
    Then The visuals should be updated and values should be displayed in the report according to the selected Period filter
    And By default, the Period filter should be selected as Current Period