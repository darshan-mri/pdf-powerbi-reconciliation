Feature: Display of As of Date in Power BI Report

  Scenario: Verifying the display of As of Date in Power BI report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the "As of" date displayed should be the current date and it should follow the format mm/dd/yyyy