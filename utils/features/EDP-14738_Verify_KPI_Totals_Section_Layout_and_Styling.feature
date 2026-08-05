Feature: KPI Totals Section Validation

  Scenario: Validate KPI totals layout
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    Then Header should be 18pt Segoe UI color #404D66
    And Accent bar should be on the left with color #6CCED5
    And Properties padding should be 16px
    And Card padding should be 8px top/bottom and 16px left/right