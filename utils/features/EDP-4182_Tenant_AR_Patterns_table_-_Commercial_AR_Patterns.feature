Feature: Commercial AR Patterns

  Scenario: Display and interact with Tenant AR Patterns table data based on selected reporting range and "As of" date
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the report
    Then the user should be able to see the title name suffixed with the selected Reporting Range along with the "As of" date
    And the table header along with proper data should be loaded
    When the user selects any of the records from the table
    Then the information related to the selected record should be displayed in key cards and other visuals