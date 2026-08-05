Background:
    Given I am logged into "https://qa-mriagorainsights.redmz.mrisoftware.com/" as "AIGDEPLOYAPP client id" and a user who has permission to create, draft, publish, and deploy reports

  Scenario: Version workspace retains only the last 5 versions after deployment cleanup
    When I create a custom report and publish and create draft for that report more than 8 times just for testing purpose
    And I wait for the deployment cleanup orchestration to run (usually after 24 hours)
    Then I verify in the Version Workspace that only the last 5 versions of the report remain(Next day)