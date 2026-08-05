##The returned fields in Postman to check are
##"isCustom": 
##"hidesReportId": 

 Background:
    Given there are standard reports and custom reports in the system
    And some custom reports hide standard reports
    And at least one custom and one standard report is hidden via Dashboard Access
	And Postman is set to MRI AIG Int - Dev (or QA)
	And Postman has been authenticated

  Scenario: Return all custom reports including hidden ones by default
    When I go to Postman MRI AIG Integration - Integration API - Reports - Get List Workspace Reports - filter (note: there are two similarly named endpoints, this is not the one filted by user)
	And I run the endpoint
    Then I should see all custom reports
    And I should see custom reports that hide standard reports
	And I should see reports that are hidden via Dashboard Access 
	##Note: If you don't see hidden or custom, double check the parameters are "AutoHideReports": False   and "isCustom":true

	When I change the query to say {"AutoHideReports": true}
	And run the endpoint again
	Then I should not see hidden reports
	And I should still see unhidden custom reports