Feature: Financial NOI Analysis Report

  Scenario: Verify "As of" date format in Financial NOI Analysis report
    Given User logs into PowerBI
    When User opens the Financial NOI Analysis report from the workspace
    Then User sees the "As of" date in the following format:
      | mm/yy |