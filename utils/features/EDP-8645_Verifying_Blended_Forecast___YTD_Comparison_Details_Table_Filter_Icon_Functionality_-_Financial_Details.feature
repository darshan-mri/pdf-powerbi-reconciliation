Feature: Financial Details + Variance Type Filter Interaction

  Scenario Outline: User selects a Variance Type filter and sees the updated visuals and applied filters
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    When the User selects the <Variance Type filter> from the Filters pane
    Then the visuals should be updated and values should be displayed in the report according to the selected Variance Type filter
    When the User hovers over the filter icon of the <Table>
    Then User should see the applied filters

    Examples:
      | Table                     | Variance Type filter |
      | YTD Comparison Details    | YTD Comparison       |
      | Blended Forecast Details  | Blended Forecast     |