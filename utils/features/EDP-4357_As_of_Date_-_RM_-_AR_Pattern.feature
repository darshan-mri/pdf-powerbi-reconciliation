Feature: Residential AR Pattern

  Scenario: Verifying the "As of date" display in the report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the "As of date" displayed should be the current date and it should follow the format mm/dd/yyyy