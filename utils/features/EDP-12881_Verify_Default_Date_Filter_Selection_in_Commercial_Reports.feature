Feature: Commercial Reports - Date Filter Selection

  Scenario: Validate that the Date filter is set to the current date by default
    Given the user logs into Power BI
    And selects the workspace
    When the user opens any Commercial Report
    Then the filter pane should be collapsed by default
    When the user clicks on the filter pane
    Then the filter pane should expand
    And the Date/Period filter should be available in the filter pane  
    And the current date or period selected by default