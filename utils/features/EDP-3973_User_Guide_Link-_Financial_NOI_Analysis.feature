Feature: Financial NOI Analysis Report

  Scenario: Verify User Guide link functionality in Financial NOI Analysis report
    Given User logs into PowerBI
    When User opens the Financial NOI Analysis report from the workspace
    When User clicks on the User Guide link
    Then User Guide page should be loaded with the correct user guide in PDF or document format