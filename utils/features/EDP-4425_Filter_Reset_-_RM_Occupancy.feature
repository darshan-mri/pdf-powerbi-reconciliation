Feature: Residential Occupancy - Filter Reset Functionality

  Scenario: User resets filters in the Filters pane for Residential Occupancy report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the Residential Occupancy report
    And expands the Filter show/hide pane
    Then The filter reset button should be displayed
    When the user applies the filter conditions from the Filters pane
    And clicks on the Filter reset button
    Then The filters applied should be set back to default state