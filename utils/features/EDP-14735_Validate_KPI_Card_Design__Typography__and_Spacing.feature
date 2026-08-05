Feature: KPI Card UI Validation

  Scenario: Validate KPI card styling
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    Then KPI value should be 24pt Segoe UI SemiBold color #162029
    And Category label should be 12pt Segoe UI color #162029
    And Card shape should be rounded rectangle
    And Corners should have 8px radius
    And Card padding should be 16px
    And Space between KPI cards should be 16px