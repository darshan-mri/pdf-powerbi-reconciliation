#Note : In environment variables, set mriclientID as currentclientID that you have logged in and set mriClientIdImpersonated to the Tenant you want to oboard (New tenantKey)
Scenario: Auto-onboard tenant via impersonation using Echo endpoint
    Given I am authenticated with an identity allowed to impersonate tenants
    And I set the mriClientId to a non-existing tenant key
    When I send a GET request to "/api/echo"
    Then the response status should be 200
    And the organisation should be created in Breeze
    And the organisation TenantKey should match the mriClientId
    And the AgoraGatewayAppTileId should not be null
  Scenario: Explicitly create or update tenant via Deploy client API
    Given I am authenticated
    And I set the mriClientId to a valid tenant key
    When I send a PUT request to "/deploy/clients/current?incremental=true&deleteOrphanedReports=false"
    Then the response status should be 200
    And the organisation should exist in Breeze
    And the organisation TenantKey should match the mriClientId
    And the AgoraGatewayAppTileId should not be null
  Scenario: Create system admin and trigger tenant onboarding
    Given I am authenticated
    And I set the mriClientId to a new tenant key
    When I send a POST request to "/api/users/sysadmin"
    Then the response status should be 200
    And the organisation should exist in Breeze
    And the organisation TenantKey should match the mriClientId
    And the AgoraGatewayAppTileId should not be null
  Scenario: Organisation is created even if Agora Gateway linking fails
    Given the Agora Gateway integration is misconfigured
    And I am authenticated
    And I set the mriClientId to a new tenant key
    When I trigger tenant creation via "/api/echo"
    Then the response status should be 200
    And the organisation should exist in Breeze
    And the organisation TenantKey should match the mriClientId
    And the AgoraGatewayAppTileId should be null
  Scenario: Compensating unlink occurs when database save fails after successful link
    Given the Agora Gateway integration is working
    And the database will fail during organisation save
    And I am authenticated
    And I set the mriClientId to a new tenant key
    When I trigger tenant creation via "/api/echo"
    Then the external Agora link attempt should succeed
    But the organisation save should fail
    And a compensating unlink request should be triggered
    And the failure should be logged