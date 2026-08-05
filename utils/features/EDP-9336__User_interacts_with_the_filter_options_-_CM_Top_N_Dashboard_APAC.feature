Feature: Commercial Top N Dashboard
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Date                  |
    | Portfolio ID - Name   |
    | Project ID - Name     |
    | Building ID - Name    |
    | Life Code             |
    | Property Type         |
    | Property Sub Type     |
    | Entity Type           |
    | Class ID              |
    | Investment Flag       |
    | Investment Type       |
    | Location ID           |
    | Occupancy Status - ID |
    | Suite Type            |
    | Owner                 |
    | Client Name           |
    | State ID              |
    | Department            |
    | Manager               |
    | Master Occupant       |
    | Asset Manager         |
    | Landlord              |
    | Tenant Type Category  |
    | SIC Code              |
    | Company Group         |
    | Store Category        |
    | Tenant Type           |
    | Suite Sq. Mt          |
    | IsActiveBuilding      |
    
  And the following filter options should have default selections:
    | Date                  | current Date        |
    | Suite Sq.Mt           | greater than 0      |
    | IsActiveBuilding      | true                |

  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter condition