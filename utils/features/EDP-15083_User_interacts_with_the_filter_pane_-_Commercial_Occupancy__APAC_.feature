Feature: Commercial Occupancy - Filter Pane APAC
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Filters               |
    |-----------------------|
    | Period Filter         |
    | Date                  |
    | Building ID - Name    |
    | Agent                 |
    | IsActiveBuilding      |
    | Group By              |
    | Suite Sq.Mt           |
    | Portfolio Name - ID   |
    | Project ID-Name       |
    | IsSuiteActive         |
    | Occupancy status      |
    
  And the following filter options should have default selections:
    | Period                | current Period      |
    | IsActiveBuilding      | true                |
    | Group By              | Building Name       |
    | IsSuiteActive         | true                |

  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter condition