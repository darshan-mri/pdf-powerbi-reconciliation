Feature: Commercial AR Insights - Filter Pane
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Date                |
    | Group by            |
    | Building ID - Name  |
    | Project ID - Name   |
    | Portfolio           |
    | Entity Type         |
    | Life Code           |
    | Property Type       |
    | Property Sub Type   |
    | Class ID            |
    | Investment Flag     |
    | Investment Type     |
    | Income Category     |
    | Location ID         |
    | State ID            |
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
    | SIC Code            |
    | Suite Status        |
    | IsActiveBuilding    |
    | ProjectID           |
    | PortfolioID         |
    | Agent               |
    
  And the following filter options should have default selections:
    | Date                  | current date    |
    | Group By              | Building Name   | 

  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter conditions