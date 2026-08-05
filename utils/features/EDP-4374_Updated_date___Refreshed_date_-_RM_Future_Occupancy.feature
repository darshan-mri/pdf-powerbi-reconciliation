Feature: Residential Future Occupancy

  Scenario: Displaying Updated Date in Correct Format
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The updated date should be displayed in the format mm/dd/yyyy