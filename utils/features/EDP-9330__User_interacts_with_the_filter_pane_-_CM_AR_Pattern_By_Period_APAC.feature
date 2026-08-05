Feature: CM AR Patterns by Period - Filter Pane APAC
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Filters             |
    |---------------------|
    | Period              |                    
    | Project ID - Name   |                    
    | Building ID - Name  |                    
    | Portfolio ID - Name |                    
    | Entity Type         |                    
    | Property Type       |                    
    | LifeCode            |                    
    | Property Sub Type   |                    
    | Investment Flag     |                    
    | Suite Type          |                    
    | Asset Manager       |                    
    | Investment Type     |                    
    | Department          |                    
    | Manager             |                    
    | Landlord            |                    
    | Master Occupant     |                    
    | Store Category      |                    
    | Tenant Type Category|                    
    | Tenant Type         |                    
    | Income Category     |                    
    | Class Id            |                    
    | Location Id         |                    
    | Client Name         |                    
    | State Id            |                    
    | Suite Status        |                    
    | Owner               |                    
    | SIC Code            |                    
    | Company Group       |                    
    | SourceCode          |                    
    | IsActiveBuilding    |                    
    | Suite Sq. Mt        |                    

  And the following filter options should have default selections:
    | period                | current period      |
    | Suite Sq.Mt           | greater than 0      |
    | IsActiveBuilding      | true                |

  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter condition