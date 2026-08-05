Feature: Client Onboarding - Domain Name Validation

  Scenario: Verify domain name and name update via deployment API
    Given I have logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/onboard-config" with clientID "AIGDEPLOYAPP"
    And the user has permission to edit the domain name
    And I have removed all existing workspaces and entire client from the DB
    When I open Postman and navigate to MRI DSG > proxied
    And I search for the request "PUT Create/update client"
    And I click "Create" and pass parameters in "domainName" and "name" fields
    And I ensure the correct environment is selected in the top-right corner
    And I save and send the request
    Then the API should process successfully
    When I return to the AIG portal and reload the clientOnboarding page
    Then I should see the updated "domainName" and "name" values match the parameters passed in the API request
    And if "domainName" is invalid I should see the error message "'DomainName' must be a valid domain name"