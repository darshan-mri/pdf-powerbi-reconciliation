##Before Scenario 1, ensure that an EmbedOnly report exists and is correctly set up with an override, the instructions below do that. 
Given I am in the SQL database
When I right-click on the reports table and load the top 1000 rows, then add the following to the query:
  # Where TenantKey = 'AIGDEPLOYAPP' and IsEmbedOnly = '1'
Then if there is an EmbedOnly report, it will be displayed
When I check the embedMinOverride
Then there should be a value, which can be identified on the role table.

Given that the EmbedOnly report does not exist or does not have an assigned minOverride
When I am in the SQL database on the reports table
And I copy the ID of a report to become EmbedOnly, or of an existing EmbedOnly report that lacks a minOverride
When I enter the following queries:
  # First query creates the EmbedOnly flag:
  update [dbo].[Report]
    set isEmbedOnly = '1'
    Where TenantKey = 'AIGDEPLOYAPP' and ID = '[ReportID]'
  
  # Second query assigns the minOverride to the creator user:
  update [dbo].[Report]
    set MINOVERRIDEEMBEDONLYROLEID = '596246AC-6D88-477B-BE62-DA329AA76B93'
    Where TenantKey = 'AIGDEPLOYAPP' and ID = '[ReportID]'

Then the database should show the report as EmbedOnly
And the minOverride should be set to '596246AC-6D88-477B-BE62-DA329AA76B93' (Creator User, adjust if QA or other role)




Scenario 1: Admin can see an EmbedOnly report in the portal
  Given I am logged in as a user with the admin role
  When I view the list of reports in the portal
  Then I should see the selected report from above, and there should be an icon beside it (currently an "E") indicating it is EmbedOnly
  # Note: If the report does not appear in the list, go to the dashboard management screen, and ensure the report is visible to the admin account or group assigned to it.


Scenario 2: A viewer user cannot see an EmbedOnly report in the portal
  Given I am logged in as a user with the role "vieweruser"
  When I view the list of reports in the portal
  Then I should not see the EmbedOnly report

Scenario 3: A viewer user cannot access the EmbedOnly report via the portal
  Given I am logged in as a user with a role that can access the EmbedOnly report, and I copy the report URL from the browser
  When I log in as a "vieweruser"
  And I try to access the report via the copied URL
  Then I should be redirected to the main page and not have access to the EmbedOnly report

Scenario 4: A creatoruser can see an EmbedOnly report in the portal
  Given I am logged in as a user with the role "creatoruser"
  When I view the list of reports in the portal
  Then I should see the EmbedOnly report listed with an icon marking it as EmbedOnly (currently a green "E")

Scenario 5: A copied report inherits the EmbedOnly and EmbedOnlyMinOverrideRoleId properties
  Given I am logged in as a user who can view EmbedOnly reports and create reports
  And I copy the existing EmbedOnly report by clicking the ellipsis at the top right when it is selected, choosing "Copy as New Dashboard", saving, and publishing it
  When I view the copied report
  Then it should have the same badge marking it as EmbedOnly
  When I refresh the report table in SQL and look for the new report
  Then the copied report should have the "EmbedOnly" property set to true
  And the "EmbedOnlyMinOverrideRoleId" should be inherited from the original report (or the role assigned during creation)