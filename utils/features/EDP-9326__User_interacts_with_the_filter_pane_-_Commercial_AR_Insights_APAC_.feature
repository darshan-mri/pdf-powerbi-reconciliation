Feature: Commercial AR Insights - Filter Pane APAC
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
    | Group by              |
    | Building ID - Name    |
    | Project ID - Name     |
    | Portfolio ID - Name   |
    | Entity Type           |
    | Life Code             |
    | Property Type         |
    | Property Sub Type     |
    | Class Id              |
    | Investment Flag       |
    | Investment Type       |
    | Income Category       |
    | Location Id           |
    | Source Code           |
    | Client Name           |
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
    | Date                  | current date        |
    | Group By              | Is master occupant  | 
    | Suite Sq.Mt           | greater than 0      |
    | IsActiveBuilding      | true                |

  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter conditions