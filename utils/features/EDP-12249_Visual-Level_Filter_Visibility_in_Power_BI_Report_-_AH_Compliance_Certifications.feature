Feature: Visual-Level Filter Visibility in Power BI Report - AH Annual Certifications
  Scenario: Ensure visual-level filters are hidden by default
    
    Given the user is logged into Power BI
    And the user has selected the appropriate workspace
    When the user opens the "AH Annual Certifications" report
    And the user clicks on following visuals
      | ---------------------Visuals--------------------------- |
      | As of Date                                              |
      | Updated Date                                            |
      | Open Certifications KeyCard                             |
      | Certifications Completed Line Chart                     |
      | Annual Recertification Line Chart                       |
      | Open Certifications by Phase Clusterd Bar Chart         |
      | Open Certification Details Table                        |
      | Open Certifications by User Clustered Bar Chart         |
      | Open Certifications Older Than 30 Days                  |
      | Completed Certifications: Rolling Prior 3 Years         |
    Then visual-level filters should not be visible by default
    And the report layout should remain clean and uncluttered