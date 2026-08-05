Feature: Commercial Rent Roll

  Scenario: User interacts with table and views related data
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the table headers along with proper data should be loaded
    When User selects any of the records from the table
    Then the data related to the selected record should be displayed in key cards and Annual rent visuals