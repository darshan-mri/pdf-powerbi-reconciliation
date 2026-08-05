Feature: Commercial Lease Expiration

  Scenario: Display current or last refreshed date in report
    Given the user is logged into Power BI
    And the user has selected the appropriate workspace
    When the user opens the Commercial Lease Expiration report
    Then the "as of" date should display the current date or last refreshed date of data model
    And the date should be displayed in the format mm/dd/yyyy