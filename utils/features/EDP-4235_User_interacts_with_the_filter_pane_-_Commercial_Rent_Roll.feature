Feature: Commercial Rent Roll
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And User clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Date                  |
    | Building ID - Name    |
    | Portfolio ID - Name   |
    | Project ID - Name     |
    | Entity Type           |
    | Life Code             |
    | Property Type         |
    | Property Sub Type     |
    | Class ID              |
    | Investment Flag       |
    | Investment Type       |
    | Location ID           |
    | State ID              |
    | Client Name           |
    | Company Group         |
    | Suite Type            |
    | Owner                 |
    | Asset Manager         |
    | Department            |
    | Manager               |
    | Landlord              |
    | Master Occupant       |
    | Store Category        |
    | Tenant Type Category  |
    | Tenant Type           |
    | SIC Code              |
    | Unit Measurement Code |
    | Suite ID              |
    | Lease ID              |
    | Occupant              |
    | Occupancy Status      |
    | IsActiveBuilding      |
    | Include 0 sq. ft additional space |
    | Agent                 |
    | Suite Type Usage      |

  And the following filter options should have default selections:
    | Date                              | current Date    |
    | IsActiveBuilding                  | true            |
    | Include 0 sq. ft additional space | Y               |


  And the filter options should update dynamically based on the selections made
  And the visuals should update to display relevant data based on the selected filter conditions