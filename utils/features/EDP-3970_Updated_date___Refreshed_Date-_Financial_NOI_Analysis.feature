Feature: Financial NOI Analysis Report

  Scenario: Verify updated date format in Financial NOI Analysis report
    Given User logs into PowerBI
    When User opens the Financial NOI Analysis report from the workspace
    Then User sees the updated date in the following format:
      | m/dd/yyyy HH:mm:ss AM/PM Timezone |