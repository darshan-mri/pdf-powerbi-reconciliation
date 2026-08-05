Feature: Commercial Top N Report
  Scenario: Displaying the Current or Last Refreshed Date
    Given the user is logged into Power BI
    And has selected the appropriate workspace
    When the user opens the "Commercial Top N" report
    Then the "As of" date should display either the current date or the last refreshed date of the data model
    And the date should be formatted as MM/DD/YYYY