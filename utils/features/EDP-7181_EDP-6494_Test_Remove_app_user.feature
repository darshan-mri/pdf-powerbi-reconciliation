#Note: This may need to be rewritten, as well as the forget user, slight changes in results, need to distinguish delete, forget, and try forget

Feature: Remove User from Organisation
  As an admin
  I want to remove a user from an organisation
  So that their related records are removed correctly
  
Before: I must create several test dashs to monitor
When I log into AIG as a non-admin account (this is the account that will be removed)
And I select any report, go to the top right and click the elipsis 
And select Copy as New Dashboard
And I name the dashboard 'TestChange[Report]' (Or any name as long as you keep track)
And I click File - > Save
And I click the ellipsis again and select Publish dashboad
Then TestChangeReport will exist
When I select any report, go to the top right and click the elipsis 
And select Copy as New Dashboard
And I name the dashboard 'TestUnpub[Report]' (Or any name as long as you keep track)
And I click File - > Save
Then I will have an unpublished report
When I select TestChangeReport, go to the top right and click the elipsis 
And select Create New Draft
And I name the dashboard 'TestDraft[Report]' (Or any name as long as you keep track)
And I click File - > Save
Then I now have a draft of the original report

Scenario: Successfully remove a user
    Given I am an admin with permission to delete users
When I open postman, assuring the environment is MRI INT - qa at the top right
And I click the square icon beside it to open up the variables, show all variables, and ensure that mriClientId is AIGDEPLOYAPP
And I click MRI AIG Integration, select the Authorization tab, and at the bottom authorize the session
And then I go to Integration API -> App Users -> Del Delete One - by username
And at the address bar put the account used to make the test reports and make sure deleteOrphanedReport is False (aig.user10@mrisoftware.disabled?deletedOrphanedReport=false)
And click Send
Then I should get a response saying the user could not be deleted due to orphaned reports

When I change the deleteOrphanedReport to True, and hit send
Then I should get a 204 response, indicating it succeeded
    And I open up an SQL editor connected to the correct environment
    And I run
    $$$$$SELECT TOP (1000) [Id]
      ,[Description]
      ,[EmbedUrl]
      ,[Name]
      ,[WebUrl]
      ,[IsDefault]
      ,[OwnerId]
      ,[ParentReportId]
      ,[IsCustom]
      ,[PeriodEnd]
      ,[PeriodStart]
      ,[TenantKey]
      ,[Version]
	    FROM [dbo].[Report]
  Where TenantKey = 'AIGDEPLOYAPP'$$$$$
  And I scroll down to find the Test reports
  And look at the OwnerId 
  Then OwnerId for the test reports should be same as the default reports (just look higher on the list to see the default reports and OwnerId)
  Then if I look at the Unpublished report in the IsDeleted column it should show '1' indicating it is soft deleted
  
  When I run the SQL Query
  $$$$$
  SELECT TOP (1000) [Id]
      ,[UserId]
      ,[LastUpdatedBy]
      ,[LastUpdatedDate]
  FROM [dbo].[ForgottenUser]
  $$$$$
  Then it should display the UserId of the forgotten account. (If it shows more than one forgotten user run the below query, inserting the userid from the ForgottenUser table)
  $$$$$
  SELECT TOP (1000) [Id]
      ,[Name]
      ,[IdentityProviderUserId]
      ,[Email]
      ,[FirstName]
      ,[LastName]
FROM [dbo].[IdentityPrincipal]
Where Id = '[UserIdFromPreviousQuery]'
$$$$$
    

  Scenario: Cannot remove self if the only client admin
    Given I am the only client admin (In AIG to to Admin Settings -> User Security Settings -> Click the Permissions tab and set yourself as client admin, and remove any others)
    When I attempt to remove myself using the Postman instructions from Scenario 1, changing the user to my email
	Then I should receive an error message "Cannot remove user as this would leave no remaining client admin to administrate the client",
    Then the deletion should be prevented
  

 #Wrong- Belongs to Forget- Scenario: Prevent removal due to multiple clients
    Given a user is onboarded to two clients (i.g. AIGDEPLOYAPP and P123456)
    When I attempt to remove the user using the postman instructions above
    Then the deletion prevented

  Scenario: Prevent removal due to higher privilege roles
    Given I log into postman with an account without any set of admin privileges
    When I put my admin account's email in the forget address and try to send
    Then the deletion should be prevented and I will receive a "No UserPrincipal found or insufficient access permissions" error