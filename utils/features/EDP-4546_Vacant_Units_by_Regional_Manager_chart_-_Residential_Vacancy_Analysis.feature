Feature: Residential Vacancy Analysis

  Scenario: User interacts with the bar chart and views data details

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the chart title should be suffixed with the period selected
    And hovering over a bar should display the tooltip value
      | Property Manager  |
      | Vacant Units      |

    When the user selects any of the bars from the graph
    Then the data related to the selected bar should be displayed in <key cards> and <other visuals>
      | key cards     |
      | Vacant Units  |
      | Vacancy %     |
      | Change %      |
      
      | Other Visuals             |
      | Vacancy % by Property     |
      | Future Vacancy Analysis   |