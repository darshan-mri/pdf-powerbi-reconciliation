Feature: Residential Occupancy & Rent Insights Report

  Scenario: View Occupancy and Rent Details
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the "Residential Occupancy & Rent Insights" report
    And clicks on "Occupancy and Rent Details"
    Then the table headers and data should load correctly for "Occupancy and Rent Details" Table
    And negative values in the table should be enclosed in parentheses ()
    When the user selects a record from the table
    Then the data related to the selected record should be displayed in key cards and other visuals