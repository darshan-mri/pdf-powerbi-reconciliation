Feature: Residential Future Occupancy

  Scenario: Displaying Scatter Chart for Corresponding Key Card
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User clicks on "More Details" from the key cards
    Then The scatter chart for the corresponding key card should be displayed
    When User Hover over on the any point in the chart
    Then the tooltips should be displayed as follows:
      | Property ID - Name             |
      | Days Occupancy %               |
      | Days Occupied Units            |
      | Total Units                    |
    When User clicks on the any point in the chart
    Then the values shoul be updated in the keycards and tables