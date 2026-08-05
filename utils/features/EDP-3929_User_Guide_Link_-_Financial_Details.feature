Feature: Financial Details + User Guide Link

  Scenario: User clicks on the User Guide link and sees the correct user guide
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    When User clicks on the User Guide link
    Then The User Guide page should be loaded with the correct user guide