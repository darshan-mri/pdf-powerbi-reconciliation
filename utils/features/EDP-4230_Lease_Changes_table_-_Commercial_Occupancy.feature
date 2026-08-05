Feature: Display Lease Charges in Power BI

  Scenario: User views Lease Charges table
    Given User logs into Power BI
    And User selects the workspace
    When User opens the Commercial Occupancy report
    Then the table headers and data should be loaded correctly
    And the column names and values should be aligned as follows:
      | Alignment | Columns                                      |
      | Left      | Lease Change Date, Portfolio ID - Name, Project ID - Name |
      | Right     | Tenant, SIC Code, Change Detail, Suite Area  |
    When User selects any record from the table
    Then the data related to the selected record should be displayed in key cards, Occupied %, and Occupancy Details visuals