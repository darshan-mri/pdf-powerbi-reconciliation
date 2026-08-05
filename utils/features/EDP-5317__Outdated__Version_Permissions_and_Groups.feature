Given I am logged into PBI in the most recent dev_P123456_Version workspace
When I click Manage Access at the top middle
And for each user group EXCEPT the Service Principal Profile, click their role, and select Remove
Then the groups should be deleted leaving only Service Principal Profile

Given I am in Postman, with the environment set to dev
When I click MRI DSG and then Authorization in the main window
And I scroll to the bottom and select Get New Access Token and sign in to authorize
When in the MRI DSG tree, under Proxied, I select Update Version Workspace, and then Send on the top right of the window
When I return to the most recent dev_P123456_Version workspace, click Manage Access
Then all the original groups that were deleted will be restored