Feature: Commercial Occupancy

  Scenario: User updates bar graph title based on selected measure condition
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And selects Occupied Area % as the measure condition
    Then the bar graph title should be suffixed with the selected measure condition along with the Group by condition selected