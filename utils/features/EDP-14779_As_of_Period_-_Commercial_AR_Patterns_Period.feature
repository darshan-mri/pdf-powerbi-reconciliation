Feature: Commercial AR Patterns Report in Power BI

  Scenario: Display current period in the report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the Residential AR Insights by Period report
    Then The "as of" date should display the current period
    And The period should be displayed in the format mm/yy