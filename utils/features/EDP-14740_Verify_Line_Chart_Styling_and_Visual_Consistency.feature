Feature: Line Chart UI Validation

  Scenario: Validate line chart styling
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    Then Line chart title should be 18pt Segoe UI color #404D66
    And Axis titles should be 12pt Segoe UI color #394756
    And Legend should be 10pt Segoe UI color #394756
    And Border should be 8px color #F1F4F6