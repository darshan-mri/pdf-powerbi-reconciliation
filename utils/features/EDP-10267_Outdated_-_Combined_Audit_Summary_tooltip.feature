##Test is written for dev and AIGDEPLOYAPP, replace with whatever environment and clientid you are working with.
Scenario: Standard report summary button should not be visible
    Given I am logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/" as "AIGDEPLOYAPP client id" and the user who have permisson to edit and publish dashboards
    When I open a standard report[Any]
    Then I should not see the summary button on top right,see the attachment

Scenario: Copying a standard report as a new dashboard and verifying summary details
   Given I'm logged into https://dev-mriagorainsights.redmz.mrisoftware.com/ client ID AIGDEPLOYAPP with an account capable of making new dashboards
   When I select a report and click the ellipsis in the top right corner selecting Copy as a new dashboard
   And I name the report Z[Report] and click Create Dashboard
   And I click File to the top left of the report and Save
   And I click the ellipsis again selecting Publish draft
   And a pop-up appears and I select New dashboard and publish dashboard
   Then the new dashboard will be published
   Then I should see the summary button at the top right, see the attachment for reference
   When I open the summary button
   Then I should see the following details:
      | Who  | My Username |
      | Team | My Team     |
      | When | Timestamp   |
      | What | Publish     |

Scenario: Creating a new draft report and verifying summary button is not visible
    Given I'm logged into https://dev-mriagorainsights.redmz.mrisoftware.com/ client ID AIGDEPLOYAPP
    When I create a new draft report for a customized report
    Then I should not see the summary button
Scenario: Verifying summary button is not visible for an unpublished report
    Given I am logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/" with client ID "AIGDEPLOYAPP" using an account capable of making new dashboards
    When I select a report and click the ellipsis in the top right corner selecting "Copy as a new dashboard"
    And I name the report "Z[Report]" and click "Create Dashboard"
    And I click "File" at the top left of the report and select "Save"
    Then for the unpublished report, the summary button on top right should not show
Scenario: Validate the skeleton loader for summary button
    # The summary button should display a skeleton loader when loading under slow network conditions.
    Given I am in a custom report
    When I press "Ctrl + Shift + I" to open Developer Tools
    And I choose the "Network" tab
    And I click on "No Throttling" and select "3G" from the dropdown
    And I navigate to another report and return to the custom report
    And I click on the summary button
    Then I should see the skeleton loader,Find in attachments for reference