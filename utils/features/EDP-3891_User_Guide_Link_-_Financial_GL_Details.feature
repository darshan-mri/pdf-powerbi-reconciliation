Feature: Financial GL Details Report User Guide Link Feature

  Scenario: Ensure the User Guide page loads with the correct document or PDF
    Given User logs into PowerBI
    And User opens Financial GL Details report from the workspace
    When User clicks on the User Guide link
    Then User Guide page should be loaded with the correct user guide in document or PDF format