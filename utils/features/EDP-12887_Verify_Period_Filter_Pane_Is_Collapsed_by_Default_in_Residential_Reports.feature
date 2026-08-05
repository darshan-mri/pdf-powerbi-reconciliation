Feature: Residential Reports - Filter Pane State

  Scenario: Validate the filter pane state
    Given the user logs into Power BI
    And selects the workspace
    When the user opens any Residential Report
    Then the filter pane should be collapsed by default