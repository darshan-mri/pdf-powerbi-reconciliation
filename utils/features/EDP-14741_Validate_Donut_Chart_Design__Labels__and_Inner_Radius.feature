Feature: Donut Chart UI Validation

  Scenario: Validate donut chart styling
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    Then the donut chart inner radius should be 65%
    And Title should be 18pt Segoe UI color #404D66
    And Legend should be 10pt Segoe UI color #394756
    And Data labels should show category and percentage
    And Padding should be 16px
    And Border should be 8px color #F1F4F6