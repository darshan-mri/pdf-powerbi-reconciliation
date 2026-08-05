Feature: Client onboarding - Agora Gateway linking

  Background:
    Given I am logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/" as client "MRIQWEB"
    And I am a global service user with permission to delete the organisation

  @regression @onboarding @agora
  Scenario: Verify client linking and unlinking with Agora Gateway
    Given I am on the client onboarding configuration page
    And the logged-in client is not already linked to Agora Gateway
    Then the button on the top right should display "Link to Agora Gateway" and be enabled

    When I click on "Link to Agora Gateway"
    Then the button text should change to "Linked to Agora Gateway"

    And I query the database table "dbo.IdentityPrinciple"
    Then the "AgoraGatewayAppTileID" column for the client should not be NULL

    When I soft delete the client from the client onboarding page
    Then the "AgoraGatewayAppTileID" column should become NULL in the database

    When I recover the deleted client
    Then the "AgoraGatewayAppTileID" column should display a new, different ID