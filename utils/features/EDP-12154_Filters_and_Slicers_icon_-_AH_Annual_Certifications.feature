Feature: Filters and Slicers Icon - AH Annual Certifications
  Scenario: User interacts with Filters and Slicers Icon on a visual
    
    Given the user is logged into Power BI
    When the user has selected appropriate workspace
    And the user has opened the "AH Annual Certifications" report
    And the report visuals are fully loaded without any breakage
    
    When the user hovers over a <Visuals>
    And the user hovers over the "Filters and Slicers affecting this visual" icon
    Then a panel should appear showing all filters and slicers currently applied to the visual
    And the panel should list each filter or slicer with its name and selected value(s)
      |                         Visuals                         |
      | ------------------------------------------------------- |
      | Late Recertifications Table                             |
      | Annual Recertification Line Chart                       |
      | Certification Load Table                                |
      | Average Days to Completion Clustered Bar Chart          |
      | Annual Recertification Details Table                    |
      | Average Days to Completion: Rolling Prior 3 Years       |