Feature: Focus Mode - Power BI Visual Interaction - AH Annual Certifications
  Scenario: User interacts with Focus Mode on a visual
    Given the user is logged into Power BI
    When the user has selected appropriate workspace
    And the user has opened the "AH Annual Certifications" report
    And the report visuals are fully loaded without any breakage
    
    When the user hovers over a <Visuals>
    And the user clicks the "Focus Mode" icon on the visual
    
    Then the visual should expand to occupy the full report canvas
    And other visuals should be temporarily hidden
    And the user should be able to interact with the visual in isolation
    
    When the user clicks the "Back to Report" button
    
    Then the report should return to its original layout
    And all visuals and filters should be visible again
    And the visual should retain its original position and formatting
      |                         Visuals                         |
      | ------------------------------------------------------- |
      | Late Recertifications Table                             |
      | Annual Recertification Line Chart                       |
      | Certification Load Table                                |
      | Average Days to Completion Clustered Bar Chart          |
      | Annual Recertification Details Table                    |
      | Average Days to Completion: Rolling Prior 3 Years       |