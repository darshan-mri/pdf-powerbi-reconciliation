Feature: Commercial AR Patterns - Filter Pane
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Filters               |
    |-----------------------|
    | Date                  |
    | Group by              |
    | Portfolio ID - Name   |
    | Source Code           |
    | Client Name           |
    | Income Category       |
    | Suite Type            |
    | Department            |
    | Manager               |
    | Landlord              |
    | Master Occupant       |
    | Store Category        |
    | Tenant Type           |
    | SIC Code              |
    | Life Code             |
    | Property Type         |
    | Building ID - Name    |
    | Class ID              |
    | Entity Type           |
    | Property Sub Type     |
    | Investment Flag       |
    | Location ID           |
    | Project ID - Name     |
    | Asset Manager         |
    | Tenant Type Category  |
    | Suite Status          |
    | Owner                 |
    | Investment Type       |
    | Company Group         |
    | State ID              |
    | Property ID - Name    |
    | IsActiveBuilding      |
    | Suite Sq. Mt          |
    
  And the following filter options should have default selections:
    | Date                  | current date        |
    | Group By              | Is Portfolio Name   | 
    | Suite Sq.Mt           | greater than 0      |
    | IsActiveBuilding      | true                |
  
  And the following filters should not allow multiple selections
    | Date                  |
    | Group By              |

  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter conditions