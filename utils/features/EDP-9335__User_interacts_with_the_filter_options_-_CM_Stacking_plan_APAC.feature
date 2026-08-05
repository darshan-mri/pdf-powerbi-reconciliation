Feature: Commercial Stacking Plan
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Date                  |
    | Entity Type           |
    | Life Code             |
    | Project ID - Name     |
    | Company Group         |
    | Property Type         |
    | Property Sub Type     |
    | Class ID              |
    | Investment Flag       |
    | Investment Type       |
    | Location ID           |
    | State ID              |
    | Client Name           |
    | Suite Type            |
    | Owner                 |
    | SIC Code              |
    | Asset Manager         |
    | Department Name       |
    | Landlord              |
    | Master Occupant       |
    | Manager               |
    | Tenant Type Category  |
    | Tenant Type           |
    | Portfolio ID - Name   |
    | Building  ID - Name   |
    | Suite ID              |
    | Sq. Mt. Type          |
    | Store Category        |
    | Unit Measurement      |
    | Suite Sq. Mt          |
    | IsActiveBuilding      |
    
  And the following filter options should have default selections:
    | Date                  | current Date        |
    | Suite Sq.Mt           | greater than 0      |
    | IsActiveBuilding      | true                |

  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter condition