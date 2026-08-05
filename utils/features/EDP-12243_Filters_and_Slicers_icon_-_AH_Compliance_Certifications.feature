Feature: Filters and Slicers Icon - AH Compliance Certifications
  Scenario: User interacts with Filters and Slicers Icon on a visual
    
    Given the user is logged into Power BI
    When the user has selected appropriate workspace
    And the user has opened the "AH Compliance Certifications" report
    And the report visuals are fully loaded without any breakage
    
    When the user hovers over a <Visuals>
    And the user hovers over the "Filters and Slicers affecting this visual" icon
    Then a panel should appear showing all filters and slicers currently applied to the visual
    And the panel should list each filter or slicer with its name and selected value(s)
    
    When the user modifies a slicer or filter listed in the panel

    Then the data in the <Visuals> should update accordingly
    And the updated filter values should be reflected in the panel
    
    When the user resets or clears the filters and slicers
    
    Then the visual should revert to its default state
      |                         Visuals                         |
      | ------------------------------------------------------- |
      | Certifications Completed Line Chart                     |
      | Annual Recertification Line Chart                       |
      | Open Certifications by Phase Clusterd Bar Chart         |
      | Open Certification Details Table                        |
      | Open Certifications by User Clustered Bar Chart         |
      | Open Certifications Older Than 10 Days                  |
      | Completed Certifications: Rolling Prior 3 Years         |