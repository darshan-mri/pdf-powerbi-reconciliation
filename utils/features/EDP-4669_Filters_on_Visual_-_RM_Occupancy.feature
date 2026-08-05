Feature: Residential Occupancy - Display Filters Applied on Visual

  Scenario: User hovers over the Filters on visual icon for any of the visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And hovers the mouse over the Filters on visual icon for any of the Residential Occupancy visuals
    Then The filters applied on the visual should be displayed