Feature: Financial GL Details Report Multi-Filter Functionality Feature

  Scenario: Ensure visuals are updated with multiple filters and display applied filters
    Given User logs into PowerBI
    And User opens Financial GL Details report from the workspace
    When User applies filters with different combinations from the filter pane
    Then the visuals should be updated and values should be displayed according to the selected filters
    When User hovers over the Filters icon in the Transaction Details table
    Then User should see the applied filters