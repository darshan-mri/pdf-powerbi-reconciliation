Feature: Commercial Occupancy

  Scenario: Update bar graph title based on selected measure condition in Power BI
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And selects "Occupied Units" as the measure condition
    Then the bar graph title should be suffixed with the selected measure condition along with the Group by condition selected
    When the user selects any of the bar in the Occupancy bar chart
    Then cross fltering should be applied in Keycard and other visuals