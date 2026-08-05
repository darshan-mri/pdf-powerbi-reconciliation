Feature: Average Days to Completion Chart - AH Annual Certifications
  Scenario: User interacts with Average Days to Completion Chart
    Given the user is logged into Power BI
    And the user has selected the appropriate workspace
    And the user opens the "AH Annual Certifications" report
    
    Then all visuals in the report should load without any breakage
    And the "Average Days to Completion" chart should be visible with the following visuals:
      | Visual Title        |
      | Clustered Bar Chart |
    
    Then the chart title should be "Average Days to Completion"
    And the subtitle should be "Last 12 Months"
    
    # Clustered Bar Chart Validation
    And the x-axis should display data for "Time to Complete"
    And the y-axis should display "UserID"
    And the y-axis should be ordered alphabetically in ascending order from top to bottom direction
    
    When the user hovers over any bar in the chart
    Then a tooltip should appear displaying the following fields:
      | Field Name                |
      | User ID                   |
      | Average of Time to Complete |