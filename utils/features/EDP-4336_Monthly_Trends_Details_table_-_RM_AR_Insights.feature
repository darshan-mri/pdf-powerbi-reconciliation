Feature: Residential AR Insights

  Scenario: User views Monthly Rent report and selects a record
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User clicks on "Monthly Rent"
    Then The table headers along with proper data should be loaded
    When User selects any of the records from the table
    Then The data related to the selected record should be displayed in key cards and other visuals