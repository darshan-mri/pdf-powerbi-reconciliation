Feature: Residential Future Occupancy

  Scenario: Resetting Filters from the Filters Pane
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User expands the Filter show/hide pane
    Then The filter reset button should be displayed
    When User applies the filter conditions from the Filters pane
    And User clicks on the Filter reset button
    Then The filters applied should be set back to their default stage