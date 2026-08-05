Feature: Commercial Lease Gantt

  Scenario: Display data for selected record in Lease Period table in Power BI
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the headers along with the proper data should be loaded for the Lease Period table
    When the user selects any of the records from the Lease Period table
    Then the data related to the selected record should be displayed in Lease details and Lease Status