Feature: Commercial Top N Dashboard

  Scenario: User interacts with the Total Sq. Ft and Rent PSF Chart
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the "Commercial Top N by Dashboard" report
    Then the scatter chart with the x and y axes names should represent the values accurately:
      | Axes | Name            |
      | x    | Total Sq. Ft    |
      | y    | Annual Rent PSF |

    When the user hovers over a data point on the scatter chart
    Then a tooltip should appear displaying additional information about the corresponding data point:
      | Selected Top N grouping |
      | Annual Rent             |
      | Total Sq. Ft            |
      | Annual Rent PSF         |

    When the user selects a data point from the chart
    Then the data related to the selected data point should be displayed in other visuals:
      | Lease Expiration        |
      | Top N details table     |
      | Top N by Grouping chart |