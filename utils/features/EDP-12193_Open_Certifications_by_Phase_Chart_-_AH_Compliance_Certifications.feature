Feature: Open Certifications by Phase Chart - AH Compliance Certifications
  Scenario: User interacts with Open Certifications by Phase Chart
    Given the user is logged into Power BI
    And the user has selected the appropriate workspace
    And the user opens the "AH Compliance Certifications" report
    
    Then all visuals in the report should load without any breakage
    And the "Open Certifications by Phase" chart should be visible with the following visuals:
      | Visual Title        |
      | Clustered Bar Chart |
    
    Then the chart title should be "Open Certifications by Phase"
    
    # Clustered Bar Chart Validation
    And the x-axis should display data for "Open Certifications"
    And the y-axis should display "CertificationPhase"
    And the y-axis should be ordered alphabetically in following Order:
      | Notice sent             |
      | No Verifications Sent   |
      | Verifications Sent      |
      | Certification           |
      | Approval                |
      | Confirmation            |
      | Certification Rejected  |
    
    And if the "CertificationPhase" Name is 'Completed' 
    Then 'Completed' Certification Phase should not be displayed on the chart's y-axis
    
    When the user clicks on any bar in the "Open Certifications by Phase" chart
    Then cross-filtering should be applied to the following visuals:
      | ---------------------Visuals--------------------------- |
      | Open Certifications KeyCard(Reference labels)           |
      | Open Certification Details Table                        |
      | Open Certifications Older Than 10 Days                  |
    
    When the user deselects the selected bar
    Then all visuals in the report should revert to their default state