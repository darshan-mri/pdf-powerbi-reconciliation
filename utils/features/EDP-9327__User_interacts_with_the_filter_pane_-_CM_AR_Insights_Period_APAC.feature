Feature: Commercial AR Insights by Period - Filter Pane APAC
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Filters               |
    |-----------------------|
    | Date                  |
    | Suite Sq. Mt          |
    | Building Name - ID    |
    | Project ID - Name     |
    | Portfolio ID - Name   |
    | Entity Type           |
    | Property Type         |
    | Property Sub Type     |
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
    | Department            |
    | Manager               |
    | Landlord              |
    | Master Occupant       |
    | Store Category        |
    | State ID              |
    | Manager               |
    | Asset Manager         |
    | Tenant Type Category  |
    | Suite Status          |
    | Owner                 |
    | Tenant Type           |
    | Company Group         |
    | SIC Code              |
    | IsActiveBuilding      |
    
  And the following filter options should have default selections:
    | Period                | current Period        |
    | Source Code           | Is Not Blank        | 
    | Suite Sq.Mt           | greater than 0      |
    | IsActiveBuilding      | true                |

  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter condition