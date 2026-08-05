Feature: Commercial AR Insights - Filter show/hide pane

  Scenario: User interacts with the filter pane
    Given the user is logged into Power BI
    And the user selects the workspace
    When the user opens the report
    And expands the Filter show/hide pane
    Then the filter reset button should be displayed
    When the user applies the filter conditions from the Filters pane
    And clicks on the Filter reset button
    Then the filters applied should be set back to the default state