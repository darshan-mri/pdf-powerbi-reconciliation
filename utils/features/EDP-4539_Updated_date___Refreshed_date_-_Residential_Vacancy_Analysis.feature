Feature: Residential Vacancy Analysis

  Scenario: User views the updated date and time in the report

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the updated date should be displayed in the following format: mm/dd/yyyy HH:MM:SS AM/PM Timezone