##Needs to be reevaluated for changes with Ask Agora. Is probably outdated, confirm with Ask Agora changes in July/August

Given I'm logged in with an account with admin priviledges and Ask Agora is enabled with at least one report
When Using SQL update one of the Ask Agora reports to be detached
##Update [dbo].[Report]
##Set IsDetached = '1' where id = '[CC4BBFDA-6CC0-4BE2-A071-92ED88A38FC0]'
And I refresh the page
Then the detached report should not show up in Ask Agora (if it was hiding another report that report will now be displayed)

When I update the ISDetached back to 0
Then the report should show up in Ask Agora again