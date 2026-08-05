Feature: Commercial TOP N Dashboard

  Scenario: User interacts with the Commercial TOP N by Occupancy Chart
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the "Commercial TOP N Dashboard" report
    Then the chart title should appear based on the selected <Grouping> with the prefix 'TOP N by ':
      | Occupant        |
      | Master Occupant |
      | Portfolio       |

    When the user hovers over a bar
    Then a tooltip should appear displaying additional information about the bar:
      | Selected option in the Top (N) Grouping  |
      | Selected option in the Top (N) Criteria  |
      | Lease End                                |
      | Total                                    |

    When the user selects any bar from the chart
    Then the data related to the selected bar should be displayed in other visuals:
      | Lease Expiration                          |
      | Top N details                             |
      | Total Sq. Ft. and Rent PSF Scatter Chart  |