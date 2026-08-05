Feature: Commercial Lease Gantt
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Filters               |
    |-----------------------|
    | Date                  |
    | Suite Sq. Mt.         |
    | Unit Measurement ID   |
    | Portfolio ID - Name   |
    | Building Id - Name    |
    | Project ID - Name     |
    | Life Code             |
    | Property Sub Type     |
    | Property Type         |
    | Entity Type           |
    | Class Id              |
    | Investment Flag       |
    | Investment Type       |
    | Location Id           |
    | Client Name           |
    | Suite Type            |
    | Owner                 |
    | State Id              |
    | Asset Manager         |
    | Manager               |
    | Landlord              |
    | Department            |
    | Master Occupant       |
    | Store Category        |
    | Tenant Type Category  |
    | Company Group         |
    | SIC Code              |
    | Tenant Type           |
    | IsActiveBuilding      |
    
  And the following filter options should have default selections:
    | Date                  | current Date        |
    | Suite Sq.Mt           | greater than 0      |
    | IsActiveBuilding      | true                |

  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter condition