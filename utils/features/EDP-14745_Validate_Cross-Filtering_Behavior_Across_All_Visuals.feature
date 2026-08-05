Feature: Cross-Filtering Validation

  Scenario: Validate cross filtering across visuals
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    And User clicks on any data point
    Then Related visuals should update accordingly
    And Selected data should be highlighted
    And Non-selected data should be faded