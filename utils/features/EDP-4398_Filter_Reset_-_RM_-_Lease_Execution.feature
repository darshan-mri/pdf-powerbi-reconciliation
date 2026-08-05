Feature: Residential Lease Execution - Filter Reset Functionality

  Scenario: User logs into Power BI, interacts with the Filter pane, and resets filters
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And expands the Filter show/hide pane
    Then The filter reset button should be displayed
    When User applies the filter conditions from the Filters pane
    And clicks on the Filter reset button
    Then The filters applied should be set back to the default state