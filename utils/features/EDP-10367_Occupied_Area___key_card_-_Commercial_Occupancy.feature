Feature: Commercial Occupancy - Occupied Area % and Key Card Validation

  Scenario: Verify Occupied Area % and Key Card Consistency
    Given the user logs into Power BI
    And the user selects the appropriate workspace
    When the user opens the "Commercial Occupancy Report"
    Then the report should display the "Occupied Area" with corresponding "Occupied Area %" values
    And the "Key Card" value should match the "Occupied Area %" from the Occupancy Details table