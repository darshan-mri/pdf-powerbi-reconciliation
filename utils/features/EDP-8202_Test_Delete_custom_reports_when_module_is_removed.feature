Feature: Delete custom reports when module is removed.
  
 Background: Create custom report and land on 'Client Onboard configuration' page.
  Given I logged in to AIG application with 'AIGDEPLOYAPP' in Dev environment # Any client ID is fine
  When I open 'Commercial AR Insights' dashboard of 'PMX Prod Template' in the All Items list # Any dashboard is fine
  And I click on the ellipsis (...) in the top right corner
  And I click 'Copy as New Dashboard'
  And I name the new dashboard as 'Test CM' and click 'Create Dashboard'
  And I save the dashboard
  And I click on the ellipsis (...) in the top right corner
  And I click 'Publish Draft'
  Then I publish the draft as a new dashboard
  And I click on the gear icon
  And I click on 'Client Onboard Configuration'
  
  Scenario:1 Add a module to the templateworkspace(s)
    When I'm on the client onboard configuration page
    And I check the Financial module of the 'PMX prod template'
    And I click save button
    Then I wait for the deployment to succeed
    # validate all the dashboards exists
    
  Scenario:2 Remove module from the templateworkspace(s) that do not contain the custom report
    When I uncheck the Financial management module of the 'PMX prod template'
    And I click save button
    Then I check no warning prompt appears
    # validate all the dashboards of Financial modules are removed after deployment.
    
  Scenario:3 Decommission the whole template workspace
    When I uncheck all the modules of 'PMX prod template'
    And I click save button
    Then I check for 'Sorry, Cannot remove already deployed workspaces' warning prompt
    # Validate deployment should not be trigger
    
  Scenario:4 Custom report details prompt should appear
    When I uncheck the Commercial management module of the 'PMX prod template' # contains custom report
    And I click save button
    Then I check warning prompt of 'The following modules contains custom reports: <Module name>-<workspace name> If you proceed to remove these modules all the associated reports will be deleted. This action can't be undone'
    
  Scenario:5 cancel the custom report prompt
    # continuation of scenario 4
    When I click cancel
    Then I check deployment did not triggred
    
  Scenario:6 Accept the custom report prompt and Check all custom and standard reports marked deletion = true before deployment
    # continuation of scenario 4
    When I click Ok
    And I check deployment triggred
    Then I immediately check all the custom and standard reports marked delete =1 in Report table
    """
    select * from [dbo].[Report] where TenantKey='AIGDEPLOYAPP' 
    """
  Scenario:7 Validate all the custom and standard reports of specific module removed in UI
    # continuation of scenario 6
    # wait for deployment to succeed
    Then I check all the standard and custom reports of Commercial Management are removed from dashboards and management.
    
  Scenario:8 Validate no prompt appears by deployning all the modules at one shot
    When I check all the modeules of PMX prod template
    And I hit save button
    Then I check no prompt appears