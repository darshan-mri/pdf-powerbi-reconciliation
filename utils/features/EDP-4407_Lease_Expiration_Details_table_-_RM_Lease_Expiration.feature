Feature: Residential Lease Expiration - Lease Expirations Table Interactions

  Scenario: User interacts with the Lease Expirations table and updates other visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And Clicks on Lease Expirations - Table
    Then The table headers along with proper data should be loaded
    When User selects any of the records from the table
    Then The data related to the selected record should be displayed in key cards and other visuals
    When The user deselects the same record
    Then The data should be reverted back to its original state
    When The user clicks on the column name of the table
    Then The table data should be sorted accordingly