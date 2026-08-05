Feature: Residential AR Patterns By Period

  Scenario: Verifying the date format display in the report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the updated date should be displayed in the following format mm/dd/yyyy