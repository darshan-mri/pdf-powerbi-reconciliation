Feature: Commercial AR Insights by Period - Filter Pane
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And User clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Period              |
    | Building ID - Name  |
    | Portfolio ID - Name |
    | Project ID - Name   |
    | Source Code         |
    | Property ID - Name  |
    | Entity Type         |
    | Life Code           |
    | Property Type       |
    | Property Sub Type   |
    | Class ID            |
    | Investment Flag     |
    | Investment Type     |
    | Income Category     |
    | Location ID         |
    | Client Name         |
    | Company Group       |
    | Suite Type          |
    | Owner               |
    | Asset Manager       |
    | Department          |
    | Manager             |
    | Landlord            |
    | Master Occupant     |
    | Store Category      |
    | Tenant Type Category|
    | Tenant Type         |
    | State ID            |
    | SIC Code            |
    | EntityTypeId        |
    | IsActiveBuilding    |
    | Suite Sq.Ft         |
    | Occupancy Status    |
    | Agent               |
  
  And the following filter options should have default selections:
    | Period                | current Period  |
    | Source code           | Is not (Blank)  |
    | Suite Sq.Ft           | greater than 0  |
    | IsActiveBuilding      | true            |
    
  And the filter options should update dynamically based on the selections made
  And the visuals should update to display relevant data based on the selected filter conditions