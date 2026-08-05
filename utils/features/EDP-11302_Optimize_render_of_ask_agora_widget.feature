Background:
    Given I am logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/" as "P123456 client id" and a user who has permission to view Ask Agora dashboards

  Scenario: Ask Agora widget shows delay on first load and caches result
#Right click anywhere in portal,inspect->Application->Local Storage->https://dev-mriagorainsights.redmz.mrisoftware.com
    When I delete the localStorage key matching format "{clientId}:{userId}:askAgora and {clientId}:{userId}:askAgoraReports "
    And I reload the page with network throttling set to "3G"
    Then I should observe a delay before the Ask Agora widget appears
    And a new entry should be created in localStorage with key "{clientId}:{userId}:askAgora and {clientId}:{userId}:askAgoraReports"
    When I reload the page again
    Then the Ask Agora widget should load instantly without delay

  Scenario: Ask Agora widget delay for a different user
    Given I login with a different user who also has permission for Ask Agora
    When I visit the same client page with network set to "3G"
    Then I should observe a delay in Ask Agora widget loading
    And localStorage should now have an entry with the new user's "{clientId}:{newUserId}:askAgora and {clientId}:{userId}:askAgoraReports"

  Scenario: Ask Agora widget delay for a different clientId
    Given I switch to a different client ID with the same user
    When I reload the page with cleared localStorage for that client
    Then the Ask Agora widget should again show a delay before appearing
    And a new localStorage entry should be created for "{newClientId}:{userId}:askAgora and {clientId}:{userId}:askAgoraReports"

  Scenario: Switch between clients and validate Ask Agora report loads for client with Ask Agora enabled
    Given I am on a client that has Ask Agora enabled
    When I switch to a different client ID that also has Ask Agora enabled
    Then the Ask Agora widget should appear without delay if cached
    And I should be able to open and view the Ask Agora reports relevant to the selected client