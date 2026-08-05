Feature: Financial Details Report Interaction

  Scenario: User interacts with the Budget Type filter
    Given the user logs into Power BI
    And the user opens the "Financial Details" report from the workspace
    And the default selection for Budget Type Filter be as follows:
    | Std. Budget |
    When the user selects any of the the "Budget Type" filter from the Filters pane
    Then the visuals of the "YTD Variance%" chart should be updated
    And the values of the "Variance Details" table should be displayed according to the selected Budget Type filter