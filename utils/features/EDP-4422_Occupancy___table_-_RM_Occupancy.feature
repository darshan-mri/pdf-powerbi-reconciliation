Feature: Residential Occupancy - Occupancy % Table Interactions

  Scenario: User interacts with the Occupancy % table
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on Occupancy % with a table icon
    Then The table headers along with proper data should be loaded
    When User selects any of the records from the table
    Then The data related to the selected record should be displayed in visuals