Feature: Commercial Lease Gantt Report

  Scenario: View and Interact with Lease Data
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the "Commercial Lease Gantt" report
    Then the table headers and data should be loaded correctly
    When the user selects a record from the table
    Then the data related to the selected record should be displayed in "Lease Status" and "Lease Period"