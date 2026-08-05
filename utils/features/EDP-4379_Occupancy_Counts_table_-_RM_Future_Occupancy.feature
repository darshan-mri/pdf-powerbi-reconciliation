Feature: Residential Future Occupancy

  Scenario: Viewing and Interacting with Table Data
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The table headers along with proper data should be loaded
    When User selects any of the records from the table
    Then The data related to the selected record should be displayed in key cards and other visuals
    When User clicks on the column name of the table
    Then The table data should be sorted by the selected column