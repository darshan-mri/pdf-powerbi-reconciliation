##Deleted user must only belong to one clientid for this to work
Scenario: Display "<user removed>" in summary after user deletion
    Given I am logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/" as "MRIQWEB" and the user has permissions to edit and publish dashboards and belongs to a single organization
    And the user performs report activities like "View" and "Publish"
    When the admin logs in with the same client ID
    And deletes the user
    And navigates to the published report
    And enables it from "Dashboard Access" if not visible
    And clicks on the "Summary" button
    Then "<user removed>" should be displayed in both "Who" and "Team" sections of the report summary