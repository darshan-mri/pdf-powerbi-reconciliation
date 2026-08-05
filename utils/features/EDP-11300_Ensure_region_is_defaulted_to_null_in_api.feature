Feature: Add or update product for a client using Update Client API and validate region handling

  Background:
    Given I am logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/" as "AIGDEPLOYAPP client id" and a user who has permission to deployment

  Scenario: Update product with region set to null in non-region-specific environment
    When I open Postman and select "MRI DSG Dev" environment
    And I select the client "AIGDEPLOYAPP" in Postman
    And I go to the "Update Client" request
    And I set the body with "templateWorkspaceName" as "Deploy Test" and "region" as null
    And I save and send the request
    Then I refresh the client page in the portal
    And I should see the newly added product with "region" set to null in the database

  Scenario: Update product with region set to "na" in non-region-specific environment
    When I open Postman and select "MRI DSG Dev" environment
    And I select the client "AIGDEPLOYAPP" in Postman
    And I go to the "Update Client" request
    And I set the body with "templateWorkspaceName" as "Deploy Test" and "region" as "na"
    And I save and send the request
    Then I refresh the client page in the portal
    And I should see the newly added product with "region" set to "na" in the database