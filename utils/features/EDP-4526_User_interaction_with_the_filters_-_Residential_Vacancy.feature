Feature: Dynamic Filter Options

Scenario: Verify dynamic filter options and visual updates
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And clicks on the Filter show/hide pane
  Then the following filter options should be displayed:
    | Date               |
    | Timeframe          |
    | Portfolio          |
    | Entity Type        |
    | Life Code          |
    | Property Type      |
    | Property Sub Type  |
    | Class ID           |
    | Investment Flag    |
    | Investment Type    |
    | Location ID        |
    | State ID           |
    | Unit Type          |
    | Owner              |
    | Asset Manager      |
    | Department         |
    | Unit               |
    | Unit Name          |
    | Resident Name      |
    | Regional Manager   |
    | Bed and Bath       |
    | Property Manager   |
    | Property ID - Name |
    | Project ID - Name  |
    | Building ID - Name |
    | IsActiveProperty   |
    | Agent              |
    
  And the filter options should update based on the changes made
  And other visuals should display relevant data based on the selected filter conditions
  And the following filter options should have default selections:
    | Date             | Current Date |
    | Timeframe        | Rolling 12   | 
    | IsActiveProperty | true         |
  And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter conditions