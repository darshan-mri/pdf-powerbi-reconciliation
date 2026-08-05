Feature: Financial GL Details Report Account Number Filter Functionality Feature

  Scenario: Ensure Account Number filter updates visuals and displays applied filters
    Given User logs into PowerBI
    And User opens Financial GL Details report from the workspace
    When User applies Account Number filter from the filter pane
    Then the visuals should be updated and values should be displayed according to the selected Account Number filter
    When User hovers over the Filters icon in the Transaction Details table
    Then User should see the applied filters