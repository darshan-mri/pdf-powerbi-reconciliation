Feature: Commercial Rent Roll
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Date                  |
    | Portfolio ID - Name   |
    | Building  ID - Name   |
    | Life Code             |
    | Occupant              |
    | Property Type         |
    | Entity Type           |
    | Unit Measurement Code |
    | Investment Flag       |
    | Class ID              |
    | Property Sub Type     |
    | Location ID           |
    | State ID              |
    | Investment Type       |
    | Owner                 |
    | Suite Type            |
    | Client Name           |
    | Department            |
    | Asset Manager         |
    | Landlord              |
    | Master Occupant       |
    | Manager               |
    | Tenant Type Category  |
    | Tenant Type           |
    | Lease ID              |
    | SIC Code              |
    | Suite ID              |
    | Occupancy Status      |
    | Company Group         |
    | Store Category        |
    | Project ID - Name     |
    | Suite Sq. Mt          |
    | IsActiveBuilding      |
    
  And the following filter options should have default selections:
    | Date                  | current Date        |
    | Suite Sq.Mt           | greater than 0      |
    | IsActiveBuilding      | true                |

  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter condition