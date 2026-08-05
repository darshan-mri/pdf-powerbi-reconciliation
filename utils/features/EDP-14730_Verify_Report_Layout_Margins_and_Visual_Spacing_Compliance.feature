Feature: Report Layout and Spacing Validation

  Scenario: Validate report layout margins and visual spacing
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    Then The report should have a 16px margin on all sides
    And The spacing between each visual should be 16px
    And No visual should overlap with another visual