Feature: Certifications Completed Chart - AH Compliance Certifications
  Scenario: User interacts with Certifications Completed Chart
    Given the user is logged into Power BI
    And the user has selected the appropriate workspace
    And the user opens the "AH Compliance Certifications" report
    
    Then all visuals in the report should load without any breakage
    And the "Certifications Completed" chart should be visible with the following visuals:
      | Visual Title |
      | KeyCard      |
      | Line Chart   |
    
    Then the chart title should be "Certifications Completed"
    And the subtitle should be "Last 3 Months"
    
    # KeyCard Validation
    And the KeyCard in the upper-right corner should display the total number of Certifications completed in "Last 3 Months"
    
    # Line Chart Validation
    And the x-axis should display Complete dates in the format "MMM YY"
    And the x-axis should be sorted in ascending order
    And the y-axis should display the number of Certifications Completed for Last 3 Months

    When the user mouse hovers on any data point in the "Certifications Completed" line chart
    Then the tooltip should be displayed with following fields:
      | Certifications Completed  |
      | Average Time To Complete  |
    
    When the user clicks on any data point in the "Certifications Completed" line chart
    
    Then the KeyCard total in the upper-right corner should update based on the selected data point
    And cross-filtering should be applied to the following visuals:
      | ---------------------Visuals--------------------------- |
      | Open Certifications KeyCard                             |
      | Open Certifications by Phase Clusterd Bar Chart         |
      | Open Certification Details Table                        |
      | Open Certifications by User Clustered Bar Chart         |
      | Open Certifications Older Than 10 Days                  |
      | Completed Certifications: Rolling Prior 3 Years         |
    
    When the user deselects the selected data point
    
    Then all visuals in the report should revert to their default state