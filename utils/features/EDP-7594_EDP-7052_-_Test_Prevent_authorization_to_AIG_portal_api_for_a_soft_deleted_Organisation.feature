Feature: Client Soft-delete and Re-enablement

  Scenario: Soft delete and re-enable a client
    Given I set the environment to "MRI DSG - Dev" in Postman
    And I set the client ID to "AIGDEPLOYAPP" in Postman
    # Note: Any client can be used, but using AIGDEPLOYAPP minimizes interference
    When I go to "Postman -> MRI DSG -> Non-proxied -> Authenticated -> Del Org-Soft Delete"
    # Note:- Sometimes 'Del Org-Soft Delete' API results 422 error code because of active deployment inflights (DEV is 1hr, QA is 72hrs)
    And I ensure the Postman request ends with "Current" or "AIGDEPLOYAPP"
    And I send the request
    When I navigate to AIG
    And I log into client "AIGDEPLOYAPP"
    Then I should see an authorization issue and an error message

  Scenario: Validate client deletion
    When I run another Postman API request (Get Breeze/Users, or something harmless)
    Then it should return a "403" or "400" error

  Scenario: Verify client absence
    Given I open an incognito browser
    When I navigate to AIG
    And I log in with "P123456"
    And I go to the bottom right to change client
    Then I should ensure "AIGDEPLOYAPP" is not available
    #Note: The deleted client (AIGDEPLOYAPP) is visible only to users with Support role or above. Users with roles below Support will not be able to view or modify the deleted client.

  Scenario: Re-enable client in database
    Given I open Microsoft SQL and connect to the dev database
    When I execute the following SQL command
    """
    UPDATE [dbo].[IdentityPrincipal]
    SET IsDeleted = 0
    WHERE TenantKey = 'AIGDEPLOYAPP' and Type = 'Organisation'(Replace Tenantkey which you deleted in above scenario),copy the id and do this command 
    UPDATE [dbo].[IdentityPrincipal]
    SET IsDeleted = 0
    WHERE id = '389B50C7-66E2-4201-9FEB-EA8074FAA664'
    SET IsDeleted = 0
    WHERE id = '389B50C7-66E2-4201-9FEB-EA8074FAA664'
    """
    #Note: Confirm the id is the correct one, QA is ATOW 05477896-B1F3-498B-9137-7E33C69F1C26, and it changes occasionally
	Then the IsDeleted column should now show 0

  Scenario: Verify client re-enablement
    Given I open an incognito browser
    When I navigate to AIG
    And I log in with "AIGDEPLOYAPP"
    Then there should be no issue

  Scenario: Validate API access post re-enablement
    When I run any API in Postman like a "Get" request
    Then it should return correctly

  Scenario: Confirm client access in AIG
    Given I am logged into AIG in a different client than the one that was soft deleted
    When I go to the bottom right to change client
    And I select "AIGDEPLOYAPP"
    Then I should confirm I can access this client again