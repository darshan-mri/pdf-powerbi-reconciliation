Feature: Residential Future Occupancy

  Scenario: Displaying Current As of Date in Correct Format
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The "As of" date displayed should be the current date
    And The "As of" date should follow the format mm/dd/yyyy