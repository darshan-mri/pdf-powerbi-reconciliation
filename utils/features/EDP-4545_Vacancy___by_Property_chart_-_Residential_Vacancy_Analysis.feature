Feature: Residential Vacancy Analysis

  Scenario: User interacts with the line chart and views data details
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the Residential Vacancy Analysis report
    Then the chart title should be suffixed with the <Period> selected
    When the user hovers over a data point
    Then the tooltip value for the data point should be displayed:
      | Property ID - Name  |
      | Vacant Units        |
      | Vacancy %           |
      | Unit Count          |
      | Property Manager    |
    When the user clicks on any of the data points from the line chart
    Then the data related to the selected data point should be displayed in <key cards> and <other visuals>
      | key cards     |
      | Vacant Units  |
      | Vacancy %     |
      | Change %      |
      
      | Other Visuals                     |
      | Vacant Units by Regional Manager  |
      | Future Vacancy Analysis           |