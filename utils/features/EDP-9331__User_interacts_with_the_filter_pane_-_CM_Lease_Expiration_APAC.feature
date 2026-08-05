Feature: Commercial Lease Expiration
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Filters               |
    |-----------------------|
    | Date                  |
    | Building ID - Name    |
    | Project ID - Name     |
    | Property ID - Name    |
    | Entity Type           |
    | Property Type         |
    | Property Sub Type     |
    | Portfolio             |
    | Investment Flag       |
    | Investment Type       |
    | Class ID              |
    | Life Code             |
    | Income Category       |
    | Suite Type            |
    | Location Id           |
    | Source Code           |
    | Client Name           |
    | Lease ID              |
    | Suite Type            |
    | Department Name       |
    | Lease Expiration Date |
    | Manager               |
    | Landlord              |
    | Master Occupant       |
    | Store Category        |
    | State ID              |
    | Manager               |
    | Asset Manager         |
    | Tenant Type Category  |
    | Owner                 |
    | Tenant Type           |
    | Company Group         |
    | SIC Code              |
    | Suite Sq. Mt          |
    | IsActiveBuilding      |
    
  And the following filter options should have default selections:
    | Date                  | current Date        |
    | Suite Sq.Mt           | greater than 0      |
    | IsActiveBuilding      | true                |

  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter condition