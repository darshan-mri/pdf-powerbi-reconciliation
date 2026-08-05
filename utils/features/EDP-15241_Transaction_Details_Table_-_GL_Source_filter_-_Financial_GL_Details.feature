Feature: Financial GL Details Report GL Source Filter Functionality Feature

  Scenario: Ensure GL Source filter updates visuals and displays applied filters
    Given User logs into PowerBI
    And User opens Financial GL Details report from the workspace
    When User applies GL Source filter from the filter pane
    Then the visuals should be updated and values should be displayed according to the selected GL Source filter
    When User hovers over the Filters icon in the Transaction Details table
    Then User should see the applied filters