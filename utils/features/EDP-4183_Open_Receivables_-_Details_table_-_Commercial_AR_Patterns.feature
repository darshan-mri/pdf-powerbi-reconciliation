Feature: Commercial AR Patterns

  Scenario: Display and interact with Open receivables - details table data
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the report
    Then the table headers along with proper data should be loaded
    When the user selects any of the records from the table
    Then the information related to the selected record should be displayed in key cards and other visuals