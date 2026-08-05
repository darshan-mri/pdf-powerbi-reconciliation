Feature: Financial Details + Variance Type Filter and Focus Mode Interaction

  Scenario Outline: User selects a Variance Type filter, views the updated visuals, and enters Focus mode for the table
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    When the User selects the <Variance Type filter> from the Filters pane
    Then the visuals should be updated and values should be displayed in the report according to the selected Variance Type filter
    When the User clicks on Focus mode for the <Table>
    Then the <Table> should be displayed in full screen with the lines and values intact
    And the user should see a back button to navigate back to the home page

    Examples:
      | Table                    | Variance Type filter |
      | YTD Comparison Details    | YTD Comparison       |
      | Blended Forecast Details  | Blended Forecast     |