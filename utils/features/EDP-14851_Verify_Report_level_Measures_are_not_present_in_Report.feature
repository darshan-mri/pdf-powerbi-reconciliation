Feature: Report Validation

  Background:
    Given the user has logged into Power BI
    And navigated to the desired workspace

  Scenario Outline: Verify Report level Measures are not present in <report_name>
    When the <report_name> is opened in Power BI Helper Tool
    Then the report should not contain any report-level measures
    And all measures should be defined at the dataset or model level
    And no custom measures should exist at the report level

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