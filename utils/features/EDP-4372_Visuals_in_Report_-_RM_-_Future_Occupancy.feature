Feature: Residential Future Occupancy

  Scenario: Loading Report Without Breaking Any Visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The report should load without breaking any visuals