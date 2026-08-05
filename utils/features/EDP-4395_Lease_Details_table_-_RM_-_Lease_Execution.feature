Feature: Residential Lease Execution - Table Interaction and Data Display

  Scenario: User logs into Power BI, interacts with the table, and views related data
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The table headers along with proper data should be loaded
      | ------Column Names------- | 
      | Lease Execution Date      |
      | Occupy Date               |
      | Lease End Date            |
      | Property ID - Name        |
      | Building ID - Name        |
      | Property Building Unit    |
      | Lease ID                  |
      | Current Rent              |
      | Prior Rent                |
      | Optimum Rent              |
      | % Change form Prior Rent  |
    When User selects any of the records from the table
    Then The data related to the selected record should be displayed in key cards and other visuals
    When User clicks on the column name of the table
    Then The table data should be sorted accordingly