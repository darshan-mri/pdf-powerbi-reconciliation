Feature: Typography Standards Validation

  Scenario: Validate typography across report
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    Then Font family should be "Segoe UI"
    And Headers should use 18pt font size with color #404D66
    And KPI values should use 24pt SemiBold with color #162029
    And Axis titles should use 12pt font size with color #394756
    And Legends should use 10pt font size with color #394756
    And Data labels should use 10pt font size with color #4C5C6B
    And Totals should use 12pt SemiBold with color #404D66