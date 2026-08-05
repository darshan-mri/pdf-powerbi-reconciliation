Feature: Commercial Stacking Plan

  Scenario: Displaying filters applied on visuals
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And hovers the mouse over the "Filters on visual" icon for any of the visuals
    Then the filters applied on the visual should be displayed