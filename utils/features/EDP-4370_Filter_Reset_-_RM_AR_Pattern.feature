Feature: Residential AR Pattern - Resetting Filters in Power BI Report

  Scenario: Verifying filter reset functionality in Power BI report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And expands the Filter show/hide pane
    Then the filter reset button should be displayed
    When the user applies the filter conditions from the Filters pane
    And clicks on the Filter reset button
    Then the filters applied should be set back to default state