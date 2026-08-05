Feature: Financial GL Details Report Sorting Feature

  Scenario: Ensure Transaction Details table can be sorted by column name
    Given User logs into PowerBI
    And User opens Financial GL Details report from the workspace
    When User clicks on any column name of Transaction Details table
    Then the Transaction Details table should be sorted accordingly