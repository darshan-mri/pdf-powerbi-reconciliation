Feature: Residential Lease Expiration - Report Load and Visual Integrity

  Scenario: User opens the report and views Residential Lease Expiration without breaking any visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The report should load without breaking any visuals
    And The Residential Lease Expiration details should be correctly displayed without breaking any visuals