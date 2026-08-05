Feature: Commercial AR Patterns

  Scenario: Apply and reset filters in the report
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the report
    And expands the Filter show/hide pane
    Then the filter reset button should be displayed
    When the user applies the filter conditions from the Filters pane
    And clicks on the filter reset button
    Then the filters applied should be set back to their default state