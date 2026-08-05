Feature: Data Model Validation

  Background:
    Given the user has logged into Power BI
    And navigated to the desired workspace

  Scenario Outline: Verify data consistency between the old and Clean Up/Updated Data Model for <report_name>
    When the report for the old <report_name> Clean Up Data Model is opened
    And the report for the updated <report_name> Clean Up Data Model is opened
    Then the data in both models should be identical
    And all measures, dimensions, column names and calculated fields should match
    And no discrepancies should exist between the old and updated models

    Examples:
      | report_name                     |
      | Commercial AR Insights          |
      | Commercial AR Insights by Period|
      | Commercial AR Patterns          |
      | Commercial AR Patterns by Period|
      | Commercial Lease Expiration     |
      | Commercial Lease Gantt          |
      | Commercial Occupancy            |
      | Commercial Rent Roll            |
      | Commercial Stacking Plan        |
      | Commercial Top N                |
      | Financial Details               |
      | Financial GL Details            |
      | Financial Hub Map               |
      | Financial NOI Analysis          |
      | Financial PortfolioHub          |