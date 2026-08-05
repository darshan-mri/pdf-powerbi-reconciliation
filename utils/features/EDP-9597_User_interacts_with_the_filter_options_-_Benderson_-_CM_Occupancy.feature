Feature: Benderson CM Occupancy
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Date                  |
    | Group By hierarchy     |
    | Group by              |
    | Group By (Level 2)    |
    | Manager               |
    | Suite Sq.ft           |
    | Portfolio ID - Name   |
    | Building ID - Name    |
    | Project ID - Name     |
    | National tenant       |
    | Client Name           |
    | Suite Type            |
    | Landlord              |
    | Master Occupant       |
    | SIC Type              |
    | Store category        |
    | Tenat Type            |
    | Life Code             |
    | Property Type         |
    | Property Sub Type     |
    | Class ID              |
    | Investment type       |
    | Investment flag       |
    | Location ID           |
    | State Id              |
    | Enity Type            |
    | Company Group         |
    | Owner                 |
    | Asset Manager         |
    | Department            |
    | Tanant Type Category  |
    | Occupancy status      |
    | Entity ID - name      |
    | Entity Type ID        |
    | User ID               |
    | Dev Type ID           |
    | Portfolio Name        |
    | District Name         |
    | Developement Group Name|
    | Cost center Owner Name|
    | Cost center Owner Type|
    | IsActiveBuilding      |
    
  And the following filter options should have default selections:
    | Date                  | current Date        |
    | Group by              | Entity ID - Name    |
    | Group By hierarchy    | Client hierarchy    |
    | Group By (Level 2)    | Entity Type         |
    | Suite Sq.Mt           | greater than 0      |
    | Entity Type ID        | F, MH, P , T or R   |
    | IsActiveBuilding      | true                |

  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter condition