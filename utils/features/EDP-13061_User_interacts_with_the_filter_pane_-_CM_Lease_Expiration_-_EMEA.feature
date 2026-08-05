Feature: Commercial Lease Expiration
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And User clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Date                |
    | Suite Sq.Ft         |
    | Building ID - Name  |
    | Project ID - Name   |
    | Property  ID - Name |
    | Portfolio           |
    | Entity Type         |
    | Life Code           |
    | Property Type       |
    | Property Sub Type   |
    | Class ID            |
    | Investment Flag     |
    | Investment Type     |
    | Location ID         |
    | State ID            |
    | Client Name         |
    | Company Group       |
    | Suite Type          |
    | Owner               |
    | Asset Manager       |
    | Department Name     |
    | Manager             |
    | Landlord            |
    | Master Occupant     |
    | Store Category      |
    | Tenant Type Category|
    | Tenant Type         |
    | SIC Code            |
    | Agent               |
  
  And the following filter options should have default selections:
    | Date                  | current Date    |
    | Suite Sq.Ft           | greater than 0  |
    
  And the filter options should update dynamically based on the selections made
  And the visuals should update to display relevant data based on the selected filter conditions