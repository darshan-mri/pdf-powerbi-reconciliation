Feature: Visual Layout Width Validation

  Scenario: Validate standard layout widths
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    Then A full-width visual should be 1408px wide
    And Two side-by-side visuals should each be 696px wide with 16px spacing
    And Three side-by-side visuals should each be 460px wide with 16px spacing
    And Four side-by-side visuals should each be 340px wide with 16px spacing
    And Combination layouts should follow:
      | Layout Type | Widths              |
      | Mixed       | 340px, 340px, 696px |
      | Mixed       | 340px, 696px, 340px |
      | Mixed       | 1052px, 340px       |