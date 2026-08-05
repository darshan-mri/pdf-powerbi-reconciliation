Feature: Visual-Level Filter Visibility in Power BI Report - AH Annual Certifications
  Scenario: Ensure visual-level filters are hidden by default
    
    Given the user is logged into Power BI
    And the user has selected the appropriate workspace
    When the user opens the "AH Annual Certifications" report
    And the user clicks on following visuals
      | ---------------------Visuals--------------------------- |
      | As of Date                                              |
      | Updated Date                                            |
      | Average Days to Complete - Last 12M KeyCard             |
      | Recertifications Due 90 Days KeyCard                    |
      | Late Recertifications Table                             |
      | Annual Recertification Line Chart                       |
      | Certification Load Table                                |
      | Average Days to Completion Clustered Bar Chart          |
      | Annual Recertification Details Table                    |
      | Average Days to Completion: Rolling Prior 3 Years       |
    Then visual-level filters should not be visible by default
    And the report layout should remain clean and uncluttered