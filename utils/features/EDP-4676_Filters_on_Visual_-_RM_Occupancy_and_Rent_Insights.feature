Feature: Residentials Occupancy and Rent Insights

  Scenario: Viewing applied filters on a visual in the report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User hovers the mouse over the Filters on visual icon for any of the visuals
    Then The filters applied on the visual should be displayed