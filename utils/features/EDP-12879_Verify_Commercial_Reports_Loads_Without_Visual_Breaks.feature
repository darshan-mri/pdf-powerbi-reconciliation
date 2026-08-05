Feature: Commericla Reports + Report Load Integrity

  Scenario: User opens Commercial Reports, reports should without breaking any visuals
    Given User logs into PowerBI
    And User selects the workspace
    When User opens any Commercial reports
    Then the report should load without breaking any visuals