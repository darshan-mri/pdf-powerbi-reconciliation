Feature: Financial Reports - Period Filter Selection

  Scenario: Validate that the Period filter is set to the current period by default
    Given the user logs into Power BI
    And selects the workspace
    When the user opens any Financial Report
    Then the filter pane should be collapsed by default
    When the user clicks on the filter pane
    Then the filter pane should expand
    And the Period filter should be available in the filter pane with the current period selected