Feature: Residential Lease Expiration - Updated Date Display and Format

  Scenario: User opens the report and sees the updated date displayed in the correct format
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The updated date should be displayed in the following format mm/dd/yyyy