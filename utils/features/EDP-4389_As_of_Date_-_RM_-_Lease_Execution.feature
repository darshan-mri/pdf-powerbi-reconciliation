Feature: Residential Lease Execution

  Scenario: User logs into Power BI and views a report with current date as "As of Date"
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The "As of Date" displayed should be the current date
    And The "As of Date" should follow the format mm/dd/yyyy