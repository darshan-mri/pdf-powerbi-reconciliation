Feature: Residential Reports - Date Filter Type Selection

  Scenario: Validate that the Date filter type is set to "Relative date" by default
    Given the user logs into Power BI
    And selects the workspace
    When the user opens any Residential Report
    Then the filter pane should be collapsed by default
    When the user clicks on the filter pane
    Then the filter pane should expand
    And the Date filter should be available in the filter pane with the filter type set to "Relative date" by default