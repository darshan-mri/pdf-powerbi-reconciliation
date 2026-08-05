Feature: Financial Portfolio Hub

  Scenario: Verify As of date format in Financial Portfolio Hub report
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    Then User sees As of date in the following format:
      | mm/yy |