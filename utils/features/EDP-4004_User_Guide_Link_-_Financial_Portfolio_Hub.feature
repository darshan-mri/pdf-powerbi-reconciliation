Feature: Financial Portfolio Hub

  Scenario: Verify User Guide link in Financial Portfolio Hub report
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    And User clicks on the User Guide link
    Then User Guide page should be loaded with the correct user guide in PDF or document format