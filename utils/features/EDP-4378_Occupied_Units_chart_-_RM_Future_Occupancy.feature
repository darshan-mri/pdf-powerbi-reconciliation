Feature: Residential Future Occupancy

  Scenario: Interacting with a Bar Chart and Viewing Data in Key Cards and Visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The x and y axes along with the legends should be aligned properly
    When User hovers the mouse over a bar from the chart
    Then The tooltip value for the bar should be displayed with following details
    | Property ID - Name  |
    | Current/30 days/60 days'/ 90 days Occupancy % |
    When User selects any of the bars from the chart
    Then The data related to the selected bar should be displayed in key cards and other visuals