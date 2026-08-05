Feature: Commercial Top N

  Scenario: Interacting with the Top N chart
    Given the user logs into Power BI
    And the user selects the desired workspace
    When the user opens the "Commercial Top N" report
    Then the chart should display a legend for selected Top (N) Grouping
    And clicking on a legend item should toggle the visibility of its corresponding segments

    When the user selects "Annual Rent", "Annual Rent PSF", or "Total Sq.Ft" from the Top (N) Criteria button
    And the user selects "Occupant", "Master Occupant", or "Portfolio" from the Top (N) Grouping dropdown
    Then the bar chart should update to reflect the selected criteria and grouping

    When the user hovers over a bar segment
    Then a tooltip should be displayed showing:
      | Lease expiration Date year               |
      | Selected option in the Top (N) Grouping  |
      | Selected option in the Top (N) Criteria  |
      | Lease End                                |
    
    When the user selects any of the bars from the graph
    Then the data related to the selected bar should be displayed in Top N details and Top N by occupant visuals