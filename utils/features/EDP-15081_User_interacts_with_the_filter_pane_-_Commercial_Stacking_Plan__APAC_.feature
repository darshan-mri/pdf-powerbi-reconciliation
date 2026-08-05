Feature: Commercial Stacking Plan - Filter Pane APAC
  
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
    | Agent                 |
    | Sq.Mt Type            |
    | Suite Sq.Mt           |
    | Project ID-Name       |
    | IsActiveBuilding      |
    | IsSuiteActive         |
    
  And the following filter options should have default selections:
    | Period                | current Period      |
    | Suite Sq.Mt           | Greater Than 0      |
    | IsActiveBuilding      | true                |
    | IsSuiteActive         | true                |

  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter conditions