Feature: Average Days to Completion: Rolling Prior 3 Years Chart - AH Annual Certifications
  Scenario: User interacts with Average Days to Completion Chart
    Given the user is logged into Power BI
    And the user has selected the appropriate workspace
    And the user opens the "AH Annual Certifications" report
    
    Then all visuals in the report should load without any breakage
    And the "Average Days to Completion: Rolling Prior 3 Years" chart should be visible with the following visuals:
      | Visual Title          |
      | Stacked Column Chart  |
      | Dropdown              |
      | Slicer                |
    
    Then the chart title should be "Average Days to Completion: Rolling Prior 3 Years"
    
    # Stacked Column Chart Validation
    And the x-axis should display "Completion Date" in the format "MMM YY"
    And the x-axis should be sorted in ascending order
    And the title of y-axis should be "Average Days to Complete"
    And the y-axis should display "Average Days to Complete" values
    And the chart shoulld display data only for 3 Years from Selected Date in Date Filter
    
    # Dropdown Validation
    And a dropdown should be displayed in the upper-right corner of the chart
    And the dropdown should be labeled as "User:"
    And the default selection should be "All"
    And the chart data should dynamically update based on the selected user(s)
    
    # Slicer Validation
    And a slicer should be present on the y-axis
    And the chart data should dynamically update based on the slicer level
    
    When the user hovers over any bar in the chart
    Then a tooltip should appear displaying the following fields:
      | Field Name               |
      | Completion Date          |
      | Average Days to Complete |
      | Earliest Complete Date   |
    
    When the user hover over the space between any two bars in the chart
    Then a tooltip should appear displaying the following fields:
      | MMM YY from Predecessor bar Average Days to Complete  |
      | MMM YY from Successor bar Average Days to Complete    |
      | Average Days to Complete Change                       |
    
    When the user clicks on any bar in the "Average Days to Completion: Rolling Prior 3 Years" chart
    Then data in the report should be limited to the following visuals:
      | ------------------Visual Name----------------------- |
      | Average Days to Complete - Last 12M KeyCard          |
      | Recertifications Due 90 Days KeyCard                 |
      | Late Recertifications Table                          |
      | Annual Recertification Line Chart                    |
      | Certification Load Table                             |
      | Average Days to Completion Stacked Chart             |
      | Annual Recertification Details Table                 |
    
    When the user deselects the selected bar
    Then all visuals in the report should revert to their original content