Feature: Financial NOI Analysis Report

  Scenario: User views and interacts with the Opex line chart and related visuals
    Given the user logs into Power BI
    When the user opens the Financial NOI Analysis report from the workspace
    Then the user sees the Opex line chart
    And the user sees the legends in the chart for:
      | Actual Operating Expenses |
      | Comparison                |
    And the user sees the Y axis with an amount range and the X axis with a period range
    And the user sees the lines with points in the chart
    And the user sees the following buttons in the chart:
      | Non-Recoverable OpEx |
      | Recoverable OpEx     |
      | Total OpEx           |
      
    When the user selects any type
    Then the chart values and visuals should be updated according to the selected type
    And the values of the NOI Variance Breakdown table should be updated based on the selected type
    
    When the user hovers over any point on the Comparison or Actual Operating Expenses line
    Then the user sees a tooltip with the following details:
      | Period                    |
      | Actual Operating Expenses |
      | Comparison                |
    And the values in the tooltip should match the values in the NOI Variance Breakdown table
    
    When the user selects any point on the chart
    Then the selected point should be highlighted and the opacity of unselected points should be reduced
    And the visuals and values in the NOI by Entity chart and NOI Variance Breakdown table should be updated based on the selected point
    
    When the user hovers over the selected point in the chart
    Then the user sees a tooltip with the following details:
      | Period                    |
      | Actual Operating Expenses |
      | Comparison                |