Feature: Display Occupancy Details in Power BI

  Scenario: User views Occupancy Details table
    Given User logs into Power BI
    And User selects the workspace
    When User opens Commercial Occupancy report
    Then the headers and data should be loaded for the Occupancy Details table
    And the column names and values should be aligned as follows:
      | Alignment | Columns                        |
      | Left      | Portfolio ID - Name, Project ID - Name |
      | Right     | Total Area, Occupied Area, Occupancy %, Occupied Area %, Occupied % prior Year, WALT, YTD Absorption |
    When User selects a record from the table
    Then the data related to the selected record should be displayed in key cards and other visuals