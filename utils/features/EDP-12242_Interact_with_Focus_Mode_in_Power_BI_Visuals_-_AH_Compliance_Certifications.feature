Feature: Focus Mode - Power BI Visual Interaction - AH Compliance Certifications
  Scenario: User interacts with Focus Mode on a visual
    Given the user is logged into Power BI
    When the user has selected appropriate workspace
    And the user has opened the "AH Compliance Certifications" report
    And the report visuals are fully loaded without any breakage
    
    When the user hovers over a <Visuals>
    And the user clicks the "Focus Mode" icon on the visual
    
    Then the visual should expand to occupy the full report canvas
    And other visuals and filters should be temporarily hidden
    And the user should be able to interact with the visual in isolation
    
    When the user clicks the "Back to Report" button
    
    Then the report should return to its original layout
    And all visuals and filters should be visible again
    And the visual should retain its original position and formatting
      | ---------------------Visuals--------------------------- |
      | Certifications Completed Line Chart                     |
      | Annual Recertification Line Chart                       |
      | Open Certifications by Phase Clusterd Bar Chart         |
      | Open Certification Details Table                        |
      | Open Certifications by User Clustered Bar Chart         |
      | Open Certifications Older Than 10 Days Table            |
      | Completed Certifications: Rolling Prior 3 Years         |