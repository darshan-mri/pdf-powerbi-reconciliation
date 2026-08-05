Feature: Commercial Rent Roll

  Scenario: Display current or last refreshed date in specific format
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the as of date should display the current date or last refreshed date
    And the date should be displayed in the following format mm/dd/yyyy