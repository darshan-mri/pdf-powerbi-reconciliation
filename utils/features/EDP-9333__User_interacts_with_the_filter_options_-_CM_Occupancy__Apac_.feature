Feature: Commercial Occupancy
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Date                 |
    | Group by             |
    | Building  ID - Name  |
    | Portfolio ID - Name  |
    | Project ID - Name    |
    | Life Code            |
    | Entity Type          |
    | Property Type        |
    | Property Sub Type    |
    | Class ID             |
    | Investment Flag      |
    | Investment Type      |
    | Location ID          |
    | Client Name          |
    | Owner                |
    | Asset Manager        |
    | Suite Type           |
    | Landlord             |
    | Department Name      |
    | Master Occupant      |
    | Manager              |
    | Tenant Type          |
    | Tenant Type Category |
    | SIC Code             |
    | State ID             |
    | Company Group        |
    | Store Category       |
    | Occupancy Status     |
    | Suite Sq. Mt         |
    | IsActiveBuilding     |
    
  And the following filter options should have default selections:
    | Date                  | current Date        |
    | Group by              | Buidling ID - Name  |
    | Suite Sq.Mt           | greater than 0      |
    | IsActiveBuilding      | true                |

  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter condition