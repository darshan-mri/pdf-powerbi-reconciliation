Feature: Residential Future Occupancy

  Scenario: Viewing and Interacting with Chart Data
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The axes and legends for the chart should be aligned properly
    When User hovers the mouse over a bar from the chart
    Then The tooltip value for the bar should be displayed with following details
    | Move Out (All)  | 
    | Move In's (All) |