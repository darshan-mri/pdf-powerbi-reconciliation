Feature: CM AR Patterns by Period - Filter Pane
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Period                | 
    | Building ID - Name    |
    | Project ID - Name     |
    | Portfolio ID - Name   |
    | Entity Type           |
    | Life Code             |
    | Property Type         |
    | Property Sub Type     |
    | Class ID              |
    | Investment Flag       |
    | Investment Type       |
    | Income Category       |
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
    | Source                |
    | Master Occupant       |
    | Store Category        |
    | Tenant Type Category  |
    | Tenant Type           |
    | SIC Code              |
    | EntityTypeId          |
    | Suite Status          |
    | IsActiveBuilding      |
    | Total Sq.Ft           | 
    | Agent                 |

  And the following filter options should have default selections:
    | Period                | current period |
    | Total Sq.Ft           | greater than 0 |
    | IsActiveBuilding      | true           |

  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter conditions