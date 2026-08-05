Feature: Annual Recertification Chart - AH Annual Certifications
  Scenario: User interacts with Annual Recertification Chart
    Given the user is logged into Power BI
    And the user has selected the appropriate workspace
    And the user opens the "AH Annual Certifications" report
    
    Then all visuals in the report should load without any breakage
    And the "Annual Recertification" chart should be visible with the following visuals:
      | Visual Title |
      | KeyCard      |
      | Line Chart   |
    
    Then the chart title should be "Annual Recertification"
    And the subtitle should be "Next 12 Months"
    
    # KeyCard Validation
    And the KeyCard in the upper-right corner should display the total number of recertifications for "Next 12 Months"
    
    # Line Chart Validation
    And the x-axis should display recertification dates in the format "MMM YY"
    And the x-axis should be sorted in ascending order
    And the y-axis should display the number of annual recertifications

    
    When the user clicks on any data point in the "Annual Recertification" line chart
    
    Then the KeyCard total in the upper-right corner should update based on the selected data point
    And cross-filtering should be applied to the following visuals:
      | Average Days to Complete - Last 12M KeyCard          |
      | Recertifications Due 90 Days KeyCard                 |
      | Late Recertifications Table                          |
      | Certification Load Table                             |
      | Average Days to Completion Clustered Bar Chart       |
      | Annual Recertification Details Table                 |
      | Average Days to Completion: Rolling Prior 3 Years    |
    
    When the user deselects the selected data point
    
    Then all visuals in the report should revert to their default state