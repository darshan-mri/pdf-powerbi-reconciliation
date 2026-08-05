Feature: Financial GL Details Report Account Filter Functionality Feature

  Scenario: Ensure Account filter updates visuals and displays applied filters
    Given User logs into PowerBI
    And User opens Financial GL Details report from the workspace
    When User applies Account Name filter from the filter pane
    Then the visuals should be updated and values should be displayed according to the selected Account filter
    When User hovers over the Filters icon in the Transaction Details table
    Then User should see the applied filters