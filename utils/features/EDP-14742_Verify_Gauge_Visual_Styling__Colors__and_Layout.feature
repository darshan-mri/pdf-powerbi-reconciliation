Feature: Gauge Visual UI Validation

  Scenario: Validate gauge styling
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    Then Fill color should be #007AC6
    And Target color should be #8BD437
    And Title should be 18pt Segoe UI SemiBold color #404D66
    And Padding should be 16px
    And Border should be 8px color #F1F4F6