Feature: Residentails Occupancy - Report Load Without Errors

  Scenario: User opens the report and ensures visuals load correctly
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the report should load without breaking any visuals