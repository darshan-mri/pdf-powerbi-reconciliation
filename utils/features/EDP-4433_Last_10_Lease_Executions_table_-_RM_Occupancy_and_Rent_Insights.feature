Feature: Residentials Occupancy and Rent Insights

  Scenario: Viewing and interacting with the table based on group by condition
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The table title should be suffixed with the Group by condition selected
    And The table headers along with the data based on the group by condition selected should be displayed
    And The number of records should not exceed 10
    When The user selects any of the records from the table
    Then The data related to the selected records should be displayed in key cards and other visuals