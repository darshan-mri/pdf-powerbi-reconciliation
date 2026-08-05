Feature: KPI Grid Layout Validation

  Scenario: Validate KPI grid layout
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    Then Each KPI card should have 8px padding
    And Background color should support Blue #3A9DD2, Green #8BD437, Tan #EA5D4
    And Border should be 8px with color #F1F4F6