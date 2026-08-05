Feature: Residential AR Insights - As of date

  Scenario: User loads a report in Power BI with correct date display
    Given the user is logged into Power BI
    And the user selects the workspace
    When the user opens any Residential report
    Then the "as of date" should display the current date or last refreshed date
    And the date should be displayed in the format "mm/dd/yyyy"