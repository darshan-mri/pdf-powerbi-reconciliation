Feature: Residential Lease Execution - Data Integrity

  Scenario: User logs into Power BI and opens the report without invalid values in visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then NaN, Null, Nill, or Blank values should not be displayed in any of the visuals