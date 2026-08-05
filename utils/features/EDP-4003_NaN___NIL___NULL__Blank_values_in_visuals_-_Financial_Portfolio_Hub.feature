Feature: Financial Portfolio Hub

  Scenario: User opens the Financial Portfolio Hub report and checks for data integrity
      Given User logs into Power BI
      When User opens the Financial Portfolio Hub report from the workspace
      Then User should not see any NaN, NIL, NULL, or blank values in the visuals