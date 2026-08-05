Feature: Residential AR Pattern

  Scenario: Verifying title and table data in Residential AR Pattern report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the User should be able to see the title name suffixed with the selected Reporting range
    And the table with headers along with proper data should be loaded
    When User selects any of the records from the table
    Then the information related to the selected record should get displayed in key cards and other visuals