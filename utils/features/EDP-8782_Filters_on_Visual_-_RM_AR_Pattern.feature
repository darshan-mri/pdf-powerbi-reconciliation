Feature: Residential AR Pattern

  Scenario: Verifying filters on visuals in the Residential AR Patterns report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the Residential AR Patterns report
    And hovers the mouse over the Filters on visual icon for any of the visuals
    Then the filters applied on the visual should be displayed