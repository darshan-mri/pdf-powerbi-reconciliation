Background:
    Given I am logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/" as "AIGDEPLOYAPP client id" and a user who has permission to create, delete, and deploy reports

  Scenario: Validate no CleanupSoftDeletedReports error after deployment and report deletion
    When I create one or more new reports in the client workspace
    And I run a deployment in QA
    And I delete the previously created reports
    And I run another deployment in QA
    Then I should not see any "CleanupSoftDeletedReports" error in App Insights in azure after the second deployment

  Scenario: Repeat deployment tests over two days to ensure stability
    Given I have access to App Insights logs for QA environment
    When I run deployments periodically over the next 2 days
    And I create and delete reports between those deployments
    Then I should consistently observe that "CleanupSoftDeletedReports" error does not appear in App Insights(Azure)