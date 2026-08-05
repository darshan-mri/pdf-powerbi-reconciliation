Feature: Residential Lease expiration - Date Display and Format

  Scenario: User opens the report and sees the current date displayed in the correct format
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The "as of date" displayed should be the current date
    And The "as of date" should follow the format mm/dd/yyyy