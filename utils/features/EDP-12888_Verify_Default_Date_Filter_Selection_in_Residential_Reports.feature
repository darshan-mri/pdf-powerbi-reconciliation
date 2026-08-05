Feature: Residential Reports - Date Filter Selection

  Scenario: Validate that the date filter is set to the current Date by default
    Given the user logs into Power BI
    And selects the workspace
    When the user opens any Residential Report
    Then the filter pane should be collapsed by default
    When the user clicks on the filter pane
    Then the filter pane should expand
    And the Date/Period filter should be available in the filter pane with the current Date/Period selected by default