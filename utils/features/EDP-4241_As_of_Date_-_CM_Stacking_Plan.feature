Feature: Commercial Stacking Plan

  Scenario: Display current date in specific format
    Given User logs into Power BI
    And User selects the workspace
    When User opens the Commercial Stacking Plan report
    Then the as of date should display the current date
    And the date should be displayed in the following format mm/dd/yyyy