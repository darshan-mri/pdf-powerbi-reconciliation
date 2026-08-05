Feature: Commercial Occupancy

  Scenario: Display current or last refreshed date in Power BI
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the "as of" date should display the current date or last refreshed date
    And the date should be displayed in the following format: mm/dd/yyyy