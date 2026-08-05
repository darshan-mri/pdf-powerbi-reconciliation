Feature: Residential AR Pattern

  Scenario: Verifying that NaN/Null/Null/Blank values are not displayed in visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then NaN/Null/Null/Blank values should not be displayed in any of the visuals