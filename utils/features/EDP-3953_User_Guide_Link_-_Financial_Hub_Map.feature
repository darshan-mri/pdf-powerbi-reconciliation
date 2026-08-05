Feature: Financial Hub Map + User Guide Access

  Scenario: User clicks on the User Guide link and sees the correct guide
    Given User logs into PowerBI
    And User opens Financial Hub Map report from the workspace
    When User clicks on the User Guide link
    Then User Guide page should be loaded with the correct user guide in PDF/document format