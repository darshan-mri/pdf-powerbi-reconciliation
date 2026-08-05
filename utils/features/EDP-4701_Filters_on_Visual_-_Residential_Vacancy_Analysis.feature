Feature: Reseidential Vacancy Analysis

  Scenario: User views filters applied on a visual
    Given the user is logged into Power BI
    And the user selects a workspace
    When the user opens a report
    And hovers over the "Filters on visual" icon
    Then the applied filters should be displayed