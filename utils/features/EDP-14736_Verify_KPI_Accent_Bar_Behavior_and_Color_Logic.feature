Feature: KPI Accent Bar Validation

  Scenario: Validate KPI accent bar
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    Then Accent bar should be visible on left or top
    And Accent bar color should be dynamic based on variance
    And Default accent color should be #6CCED5
    And Positive color should be #8BD437
    And Negative color should be #EA5D4