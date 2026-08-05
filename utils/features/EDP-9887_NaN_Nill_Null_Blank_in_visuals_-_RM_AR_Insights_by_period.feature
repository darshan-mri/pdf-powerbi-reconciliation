Feature: Residential AR Insights By Period

  Scenario: Ensuring No Null or Invalid Values in Any Visual
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then NaN, Null, Nil, or Blank values should not be displayed in any of the visuals