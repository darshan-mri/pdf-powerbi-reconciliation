Feature: Residential AR Pattern Report

  Scenario: User views filters applied to a visual by hovering over the Filters on Visual icon
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And the user hovers the mouse over the Filters on Visual icon for any of the visuals
    Then the filters applied on the visual should be displayed