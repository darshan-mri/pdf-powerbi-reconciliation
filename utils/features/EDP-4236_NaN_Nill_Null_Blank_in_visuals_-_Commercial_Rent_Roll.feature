Feature: Commercial Rent Roll

  Scenario: Handle NaN/Null/Nil/Blank values in visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then NaN/Null/Nil/Blank values should not be displayed in any of the visuals