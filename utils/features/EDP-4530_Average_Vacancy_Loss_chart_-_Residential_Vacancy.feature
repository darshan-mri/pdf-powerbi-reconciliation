Feature: Average Vacancy Loss Chart - Residential Vacancy

Scenario: Verify axes alignment and data point interactions for Average Vacancy Loss chart
  Given User logs into Power BI
  And User selects the workspace
  When User opens the Residential Vacancy report
  Then the x and y axes should be aligned properly for the chart
    | Axes  | Name  |
    | x     | Total Days Vacant |
    | y     | vacancy Loss      |
  When User hovers the mouse over a data point
  Then the tooltip value for the data point should be displayed
    | Property ID - Name  |
    | Total Days vacant   |
    | Vacancy Loss        |
    | Vacancy Rate        |
  When User clicks on any of the data points from the line chart
  Then the data related to the data point selected should be displayed in <key cards> and <other visuals>
    | Key cards |
    | Vacancy Rate  |
    | Total Days Vacant |
    | Vacancy Loss  |
    
    | Other Visuals |
    | Days Vacant Details table |
    | Days Vacant Analysis Chart  |