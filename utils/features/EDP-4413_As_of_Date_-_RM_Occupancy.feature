Feature: Residentails Occupancy -  Display "As of" Date

  Scenario: User opens the report and sees the "As of" date in the correct format
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the "As of" date displayed should be the current date and it should follow the format mm/dd/yyyy