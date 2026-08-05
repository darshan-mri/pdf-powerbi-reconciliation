Feature: Visuals in the Report - AH Annual Certifications

  Scenario: Verify visuals in AH Annual Certifications report load successfully
    Given the user logs into Power BI
    When the user selects appropriate Workspace
    And the user opens the "AH Annual Certifications" report
    Then the following <Visuals> should load successfully without any breakage:
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