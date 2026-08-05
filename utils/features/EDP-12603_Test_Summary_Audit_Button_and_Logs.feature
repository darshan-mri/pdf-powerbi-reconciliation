Scenario: Summary button is not visible in standard report
  Given I am a user with permission to edit and publish dashboards
  When I open a standard report
  Then I should not see the summary button on the top right

Scenario: Summary button appears after publishing the report
  When I copy any report as a new dashboard named "Z[Report]"
  And I click File > Save
  And I publish the draft as a new dashboard
  Then I should see the summary button on the top right
  When I open the summary button
  Then I should see the following details:
    | Who  | My Username |
    | Team | My Team     |
    | When | Timestamp   |
    | What | Publish     |

Scenario: Skeleton loader is displayed under slow network
  Given I am viewing a custom report
    When I press "Ctrl + Shift + I" to open Developer Tools
    And I choose the "Network" tab
    And I click on "No Throttling" and select "3G" from the dropdown
  And I navigate away and return to the report
  And I click on the summary button
  Then I should see the skeleton loader

Scenario: Display "<user removed>" in summary after user deletion
##Deleted user must only belong to one clientid for this to work
    Given I am logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/" as "MRIQWEB" and the user has permissions to edit and publish dashboards and belongs to a single organization
    And the user performs report activities like "View" and "Publish"
    When the admin logs in with the same client ID
    And deletes the user
    And navigates to the published report
    And enables it from "Dashboard Access" if not visible
    And clicks on the "Summary" button
    Then "<user removed>" should be displayed in both "Who" and "Team" sections of the report summary

Scenario: Report audit record is saved with correct timestamps
  Given I have created and published a report named "ZCopy of [Dashboard]"
  When I query the Azure database for report ID and related activity
SELECT TOP (1000) * FROM [dbo].[Report] order by  name desc
  Then the report activity should contain:
    | Field          | Expected Value                 |
    | LastUpdatedBy  | IdentityPrincipal.Id           |
    | LastUpdatedDate| Current UTC timestamp (server) |