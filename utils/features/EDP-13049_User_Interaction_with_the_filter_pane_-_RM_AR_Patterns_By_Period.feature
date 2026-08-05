Feature: Residential AR Insights By Period

  Scenario: User applies filters to update visuals in the Power BI report
      Given The User logs into Power BI
      And The User opens the report from the workspace
      When The User applies the following filters from the filter pane:
        | Filters             |
        | Period filter       |
        | Portfolio           |
        | Entity Type         |
        | Source Code         |
        | Life Code           |
        | Property Type       |
        | Property Sub Type   |
        | Class ID            |
        | Investment Flag     |
        | Investment Type     |
        | Location ID         |
        | State ID            |
        | Unit Type           |
        | Owner               |
        | Asset Manager       |
        | Department          |
        | Unit                |
        | Resident Name       |
        | Regional manager    |
        | Property Manager    |
        | Charge Codes        |
        | Building ID - Name  |
        | Property ID  - Name |
        | IsActiveProperty    |
        | Agent               |
        
      Then The visuals in the report are updated and display values according to the selected filters