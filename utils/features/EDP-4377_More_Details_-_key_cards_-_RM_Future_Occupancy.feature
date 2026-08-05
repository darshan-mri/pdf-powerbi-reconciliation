Feature: Residential Future Occupancy

  Scenario: Displaying Scatter Chart for Corresponding Key Card
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User clicks on "More Details" from the key cards
    Then The scatter chart for the corresponding key card should be displayed