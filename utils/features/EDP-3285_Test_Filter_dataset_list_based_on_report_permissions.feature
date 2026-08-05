Given I am logged into my OktaPreview account and open AIG https://dev-mriagorainsights.redmz.mrisoftware.com/
When I click Dashboard Access (3 Squares and a +)), click Organisation Access, under Access toggle the first three to off if they are not already, note what they are, and click save
#Current default everyone has access to everything, so some have to be disabled to test#
And I click User, find my own name, and enable the top three, and click save
And I click the Dashboard icon, and click into All items
Then I should see all reports
#The top three were manually assigned, the rest are default access#

#Use a different browser so both accounts can be logged in at the same time#
Given I log in as a test account like AIG User1
When I click Dashboards, and All items
Then the three disabled in the last scenario should not be visible

Given I am on my admin account
When I click Dashboard Management, and click Add Item at the bottom, and name the new group TestTemp, and Create group
When I scroll to the bottom of the Access list, and find the three disabled dashboards, and click the top one to enable it, and save
And click Users, and select the test account, and click the box to the right of TestTemp
And under Dashboards to the right, under Access, click the first disabled dashboard to enable it, and click save

Given I am logged into the test account
When I refresh the page, and return to All items
Then the first two dashboards that were disabled at the start should be visible, but the third option is not
#This confirms the filtering by Organisation level, group level, and user level, and that they do not conflict#