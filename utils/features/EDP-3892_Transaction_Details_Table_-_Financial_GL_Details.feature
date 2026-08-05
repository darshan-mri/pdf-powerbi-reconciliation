Feature: Financial GL Details Report Data Consistency Feature

  Scenario: Ensure the Transaction Details table data matches the Total value
    Given User logs into PowerBI
    And User opens Financial GL Details report from the workspace
    Then User should see the Transaction Details table with the proper data loaded
    And Total value should match with Total key card