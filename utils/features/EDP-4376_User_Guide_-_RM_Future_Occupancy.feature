Feature: Residential Future Occupancy

  Scenario: Loading the User Guide for the Corresponding Report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User clicks on the User guide link
    Then The User guide for the corresponding report should be loaded