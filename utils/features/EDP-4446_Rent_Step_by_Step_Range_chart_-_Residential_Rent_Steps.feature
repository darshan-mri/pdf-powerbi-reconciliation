Feature: Residential Rent Step - Chart Data Interaction and Display

  Scenario: Verifying data interaction and display for data points in Power BI report
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the x and y axes along with proper data should be loaded
    When the user hovers over a data point
    Then the tooltip should display the below <Values> in pie Chart Format:
      | Number of Steps in that Range |
      | Distribution of Regional Manager|
    And the header of the tooltip should be titled as 'Step Count by Regional Manager'
    And the footer of the tooltip should be titled as <Step Range>:
      | <-20            |
      | >0 and <=20     |
      | >20             |
      | >= -20 and <0   |
      | No Change       |
      | Single Step     |
    When the user selects any of the data points from the chart
    Then the data related to the selected data point should be displayed in <other visuals>
      | Rent Step Count by Regional Manager |
      | Rent Step Summary                   |
      | Rent Step Details                   |