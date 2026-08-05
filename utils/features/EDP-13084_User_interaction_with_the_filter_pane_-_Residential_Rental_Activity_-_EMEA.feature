Feature: Residential Rental Activity
  
  Scenario:Validate filter pane functionality and data updates based on filter selections
    Given the user logs into Power BI  
    And the user selects the workspace  
    When the user opens the report  
    And clicks on the Filter show/hide pane  
    Then the following filter options should be displayed:  
      | Filter Name          |  
      | Date                 |  
      | Portfolio            |
      | Project              |
      | Entity Type          |  
      | Life Code            |  
      | Property Type        |  
      | Property Sub Type    |  
      | Class ID             |  
      | Investment Flag      |  
      | Investment Type      |  
      | Location ID          |  
      | State ID             |  
      | Unit Type            |  
      | Owner                |  
      | Asset Manager        |  
      | Department           |  
      | Property             |
      | Building Name        |
      | Unit ID              |  
      | Tenant Name          |  
      | Agent                |  

    And the following filters should have default selections:  
      | Filter Name       | Default Value  |  
      | Date              | Current Date   |  

    And the filter options should update dynamically based on the selections made  
    And the visuals should display relevant data based on the selected filter conditions