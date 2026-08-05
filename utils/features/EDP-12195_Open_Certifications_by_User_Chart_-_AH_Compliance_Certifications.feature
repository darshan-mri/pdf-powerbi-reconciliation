Feature: Open Certifications by Phase Chart - AH Compliance Certifications
  Scenario: User interacts with Open Certifications by User Chart
    Given the user is logged into Power BI
    And the user has selected the appropriate workspace
    And the user opens the "AH Compliance Certifications" report
    
    Then all visuals in the report should load without any breakage
    And the "Open Certifications by User" chart should be visible with the following visuals:
      | Visual Title        |
      | Clustered Bar Chart |
    
    Then the chart title should be "Open Certifications by User"
    
    # Clustered Bar Chart Validation
    And the x-axis should display data for "Open Certifications"
    And the y-axis should display "UserID"
    And the y-axis should be ordered alphabetically in ascending order from top to bottom direction
    
    When the user mouse hovers on any bar in the "Open Certifications by User" chart
    Then the tooltip should display with following fields:
      | UserID              |
      | Open Certifications |
    
    When the user clicks on any bar in the "Open Certifications by Phase" chart
    Then cross-filtering should be applied to the following visuals:
      | ---------------------Visuals--------------------------- |
      | Open Certifications KeyCard                             |
      | Certifications Completed Line Chart                     |
      | Open Certifications by Phase                            |
      | Open Certification Details Table                        |
      | Open Certifications Older Than 10 Days Table            |
    
    When the user deselects the selected bar
    Then all visuals in the report should revert to their default state