Feature: Commercial Lease Gantt

  Scenario: Reset filters in Power BI
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And expands the Filter show/hide pane
    Then the filter reset button should be displayed
    When the user applies the filter conditions from the Filters pane
    And clicks on the filter reset button
    Then the filters applied should be set back to the default state