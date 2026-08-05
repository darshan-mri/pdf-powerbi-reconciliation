Feature: Commercial AR Patterns - Filter Pane
Scenario: User applies filter options from the Filter show/hide pane
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And User clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Date                |
    | Portfolio ID - Name |
    | Building ID - Name  |
    | Entity Type         |
    | Life Code           |
    | Property Type       |
    | Property Sub Type   |
    | Project ID - Name   |
    | Class ID            |
    | Investment Flag     |
    | Investment Type     |
    | Location ID         |
    | State ID            |
    | Client Name         |
    | Company Group       |
    | Suite Type          |
    | Asset Manager       |
    | Department          |
    | Manager             |
    | Landlord            |
    | Source              |
    | Master Occupant     |
    | Store Category      |
    | Tenant Type         |
    | Income Category     |
    | SIC Code            |
    | Suite Sq.Mt         |
    | IsActiveBuilding    |
    | Agent               |
    
  And the following filter options should have default selections:
    | Date                  | current Date    |
    | Group By              | Master Occupant | 
    | Suite Sq.Mt           | greater than 0  |
    | IsActiveBuilding      | true            |

  When User selects filter options and applies the selections
  Then the filter options should update based on the selections made
  And the visuals in the report should display relevant data based on the selected filter conditions