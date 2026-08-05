Feature: Residential Rent Step - Chart Interaction and Data Display

  Scenario: Verifying chart interactions and data display in Power BI report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the axes along with legends should be aligned properly
    And the data should be grouped based on the Regional Managers
    When the User hovers the mouse over a bar from the chart
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
    When the user selects any of the bars from the chart
    Then the data related to the selected bar should be displayed in key cards and other visuals
    When the user selects any of the legends from the chart
    Then the data for the selected legend should be displayed