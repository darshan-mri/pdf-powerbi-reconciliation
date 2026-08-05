Feature: Financial Portfolio Hub

  Scenario: Verify Revenues keycard in Financial Portfolio Hub report
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    Then User should see Revenues keycard with the following elements:
      | Revenue amount |
      | Revenue %      |
      | More Details Button |