Feature: Visuals in the Report - AH Compliance Certifications

  Scenario: Verify visuals in AH Compliance Certifications report load successfully
    Given the user logs into Power BI
    When the user selects appropriate Workspace
    And the user opens the "AH Compliance Certifications" report
    Then the following <Visuals> should load successfully without any breakage:
      | ---------------------Visuals--------------------------- |
      | As of Date                                              |
      | Updated Date                                            |
      | Open Certifications KeyCard                             |
      | Certifications Completed Line Chart                     |
      | Annual Recertification Line Chart                       |
      | Open Certifications by Phase Clusterd Bar Chart         |
      | Open Certification Details Table                        |
      | Open Certifications by User Clustered Bar Chart         |
      | Open Certifications Older Than 10 Days Table            |
      | Completed Certifications: Rolling Prior 3 Years         |