Feature: Residentials Occupancy and Rent Insights

  Scenario: Resetting filters in the Filters pane
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User expands the Filter show/hide pane
    Then The filter reset button should be displayed
    When The user applies the filter conditions from the Filters pane
    And The user clicks on the Filter reset button
    Then The filters applied should be set back to default state