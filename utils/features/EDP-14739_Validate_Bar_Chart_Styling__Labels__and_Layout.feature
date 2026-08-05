Feature: Bar Chart UI Validation

  Scenario: Validate bar chart styling
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    Then Axis titles should be 12pt Segoe UI color #394756
    And Legend should be 10pt Segoe UI color #394756
    And Data labels should be 10pt Segoe UI color #4C5C6B
    And Background should be ON with color #FFFFFF
    And Border should be 8px color #F1F4F6