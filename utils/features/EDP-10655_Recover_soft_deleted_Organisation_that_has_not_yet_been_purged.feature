Given I am logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/" as "MRITEST client id"(Can use any client id) and the user must be global service user
    And I navigate to client Onboard Configuration
    When I click on the "Delete" button for the client
    Then I should see a "Confirm Delete" prompt
    And I enter the client name or paste the client ID using the copy icon
    And I click on the "Delete" button again
    Then I should be redirected to the "Confirm Delete" page
    Then I should see the message:
      """
      The Organisation and associated PBI workspaces have been marked for deletion. The actual purge will occur after a delay of seven days.
      """
    And I click on "Sign Out" on the deletion scheduled screen
    When I log in with a different client ID using a user who has the "Global Service" role
    And I go to the "Client Switch" dropdown
    Then I should see the deleted client ID displayed as "(deleted)MRITEST"
    When I select the deleted client ID and click "Select"
    Then I should be taken to the "Organisation Recovery" page
    And I should see the message:
      """
      The client with name "MRITEST" has been scheduled for deletion. To recover the client, please click the "Recover" button below.
      """
    When I click the "Recover" button
    Then I should be navigated to the "Client Onboarding" page of the deleted client
    And I should see the correct client ID displayed on the "Client Onboarding" pageAA