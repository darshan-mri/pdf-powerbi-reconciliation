Feature: Days Vacant Analysis Chart - Residential Vacancy

  Scenario: Verify chart alignment and interactions for Days Vacant Analysis
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on Days Vacant Analysis
    Then the x and y axes along with legends should be aligned properly:
      | Axes  | Name          |
      | x     | Month & Year  |
      | y     | Vacant Days   |
    And the line and stacked column chart with proper data should be loaded
    When the user hovers over any of the bars from the chart
    Then the tooltip value for the bar should be displayed:
      | EffectiveDate Month & Year |
      | Group by Condition Name    |
      | Vacant Days                |
      | Earliest EffectiveDate     |
      | Vacancy Rate               |
      | Vacancy Loss               |
    When the user clicks on any of the bars from the chart
    Then the data related to the selected bar should be displayed in key cards and other visuals
    When the user clicks on any of the <group by> conditions from the chart:
      | Building ID - Name  |
      | Regional Manager    |
      | Unit Name           |
      | Bed and Bath        |
      | Property ID - Name  |
    Then the data should be grouped based on the condition selected