Feature: Financial Details + Multiple Filter Combinations Interaction

  Scenario: User applies filters with different combinations from the filter pane
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    When User applies filters with different combinations from the filter pane
    Then The visuals should be updated
    And values should be displayed according to the selected filters