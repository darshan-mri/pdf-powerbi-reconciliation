Feature: Residential Rent Step

  Scenario: Verifying the display of filters applied to a visual in the Residential Rent report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And hovers the mouse over the Filters on visual icon for any of the visuals
    Then the filters applied on the visual should be displayed