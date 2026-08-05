Feature: Commercial AR Patterns

  Scenario: Display As of date in report
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the report
    Then the "as of" date should display the current date or last refreshed date
    And the date should be displayed in the format mm/dd/yyyy