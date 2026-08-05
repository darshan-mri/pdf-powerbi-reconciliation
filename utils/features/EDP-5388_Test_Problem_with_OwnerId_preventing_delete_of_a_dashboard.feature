Given I am logged into AIG with admin priviledges 
When I click All Items at the top left
And select any report, go the top right ellispsis 
Then Delete should not be available for standard reports

When I select "Create New Draft" naming it ZCopy[Draft]
And I save and Publish the dash
Then the report should be created

When I go to Dashboard Management,the wrench icon to the left
And scroll down to ZCopy[Draft] and toggle the accesss button to Yes
Then ZCopy is now visable by other users

Given I log into AIG as aig.creatoruser@mrisoftware.disabled (in a separate browser to make it easier)
When I follow the previous steps creating a ZZCopy of the report
And back in the admin account using the above instructions I set this report as visable for everyone
And returning to the creatoruser, under All Items, the ZCopy made previously 
And clicking the top right ellipsis 
Then option to Delete should be greyed out

When I look for the 'ZZCopy'clicking the ellipsis I Copy as a new draft 'ZZZCopy'
And I save and publish the report
When I click the ellipsis 
Then I will have the ability to delete the report

Given I am logged into AIG as aig.vieweruser@mrisoftware.disabled (this can be the same browser as creator user, they are no longer needed
When I click All Items, and find ZCopy and click the ellpisis 
Then I will not have the option to deleted

Given I return to the admin account
When I click All Items, and look for ZCopy, ZZCopy, and zzzCopy when I click the ellipsis 
And I delete the reports
Then the system will be back to its initial state.