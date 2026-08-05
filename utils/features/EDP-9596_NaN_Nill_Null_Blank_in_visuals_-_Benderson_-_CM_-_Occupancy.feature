Feature: Benderson CM Occupancy
Scenario: User logs into Power BI and views the report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then No NaN, Null, Nil, or Blank values should be displayed in any of the visuals