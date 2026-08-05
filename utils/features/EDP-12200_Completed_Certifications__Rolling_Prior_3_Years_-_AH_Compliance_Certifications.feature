Feature: Completed Certifications: Rolling Prior 3 Years Chart - AH Compliance Certifications
  Scenario: User interacts with Completed Certifications Chart
    Given the user is logged into Power BI
    And the user has selected the appropriate workspace
    And the user opens the "AH Compliance Certifications" report
    
    Then all visuals in the report should load without any breakage
    And the "Completed Certifications: Rolling Prior 3 Years" chart should be visible with the following visuals:
      | Visual Title          |
      | Stacked Column Chart  |
      | Dropdown              |
      | Slicer                |
    
    Then the chart title should be "Completed Certifications: Rolling Prior 3 Years"
    
    # Stacked Column Chart Validation
    And the x-axis should display "Completion Date" in the format "MMM YY"
    And the x-axis should be sorted in ascending order
    And the y-axis should display "CertificationPhaseID" values
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
      | Certifications           |
      | Earliest Complete Date   |
    
    When the user hover over the space between any two bars in the chart
    Then a tooltip should appear displaying the following fields:
      | MMM YY from Predecessor bar Certifications  |
      | MMM YY from Successor bar Certifications    |
      | Certifications Change                       |
    
    When the user clicks on any bar in the "Completed Certifications: Rolling Prior 3 Years" chart
    Then cross-filtering should be applied to the following visuals:
      | -------------------Visual Name------------------------- |
      | Open Certifications KeyCard                             |
      | Certifications Completed Line Chart                     |
      | Annual Recertification Line Chart                       |
      | Open Certifications by Phase Clusterd Bar Chart         |
      | Open Certification Details Table                        |
      | Open Certifications by User Clustered Bar Chart         |
      | Open Certifications Older Than 30 Days                  |
    
    When the user deselects the selected bar
    Then all visuals in the report should revert to their default state