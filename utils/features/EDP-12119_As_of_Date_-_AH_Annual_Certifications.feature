Feature: Affordable Housing - AH Annual Certifications

  Scenario: Verify that the 'As Of' date is displayed correctly
    Given the user is logged into Power BI
    When the user selects the appropriate workspace
    And the user opens the "AH Annual Certifications" report
    Then the report should load without any visual breakage
    And the 'As Of' date field should display the current date or the last refreshed date from the data model
    And the date should be displayed in the format "M/D/YYYY"