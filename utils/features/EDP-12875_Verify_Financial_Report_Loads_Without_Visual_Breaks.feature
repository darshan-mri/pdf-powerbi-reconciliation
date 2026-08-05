Feature: Financial Reports + Report Load Integrity

  Scenario: User opens Financial Reports, reports should without breaking any visuals
    Given User logs into PowerBI
    And User selects the workspace
    When User opens any Financial reports
    Then the report should load without breaking any visuals