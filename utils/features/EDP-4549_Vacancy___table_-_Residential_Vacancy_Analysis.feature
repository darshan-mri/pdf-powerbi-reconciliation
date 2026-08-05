Feature: Residential Vacancy Analysis

  Scenario: User views table details from Vacancy % key card

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on "More Details" from the Vacancy % key card
    Then the table headers along with proper data should be loaded

    When the user selects any of the records from the table
    Then the data related to the selected record should be displayed in key cards and other visuals