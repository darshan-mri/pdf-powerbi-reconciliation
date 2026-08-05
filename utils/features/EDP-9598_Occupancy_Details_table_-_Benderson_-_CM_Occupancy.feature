Feature: Benderson CM Occupancy
Scenario: User views Occupancy Details table and interacts with the data
    Given User logs into Power BI
    And User selects the workspace
    When User opens Commercial Occupancy report
    Then The headers and data should be loaded for the Occupancy Details table
    And The column names and values should be aligned as follows:
      | Alignment | Columns                                |
      | Left      | Portfolio ID - Name, Project ID - Name |
      | Right     | Total Area, Occupied Area, Occupancy %, Occupied Area %, Occupied % prior Year, WALT, YTD Absorption |
    When User selects a record from the table
    Then The data related to the selected record should be displayed in key cards and other visuals
    When User deselects the selected record
    Then The data for all visuals should revert back to the default state