##Needs to be reevaluated and rewritten, concepts still work, but process of onboarding has changed

Feature: Onboard multiple workspaces in UI
  
  # ClientID = AIGDEPLOYAPP
  #Scenario: 1 Validate domain name textfield contain '@' symbol
  #  Given I access AIG web application
  #  When I navigate to Client onboard configuration page
  #  Then I check Domain Name textfield contain '@' symbol
    
  #Scenario: 2 Cancel button disabled only while onboarding for the first time
  #  Given I access AIG web application
  #  When I navigate to Client onboard configuration page
  #  And I check the few options
  #  Then I check the Cancel button is disabled # for the same scenario on deployment, cancel button is enabled
    
  #Scenario: 3 Validate region dropdown selected Null while onboarding
  #  Given I access AIG web application
  #  When I navigate to Client onboard configuration page
   # Then I check Region dropdown selected Null
    
  #Scenario: 4 If selected Region is same as  Environment Region than store null in Organisation workspace Table
  #  When If by default environment region is NA in Region dropdown
  #  And I select NA in region dropdown
  #  And I click Save button
  #  Then I check Null is recorded in Organisation workspace Table #SELECT * FROM [dbo].[OrganisationWorkspace] where tenantkey='aigdeployapp'
    
  Scenario: 5 Deploy multiple workspaces from different template workspace by adding at once
    When I check Financial Management from PMX Prod Template and Commercial Management from PMX Test template
    And I click save button
    Then I check the deployment is successful
    
  Scenario: 6 Deploy multiple workspaces from different template workspace by adding one after another
    When I check Commercial Management from PMX Prod Template
    And I click save button
    And I immediately check Residential Management from PMX Test Template
    And I click save button
    Then I check the deployment is successful
    
  Scenario: 7 Deploy multiple workspaces from different template workspace by removeing at once
    When I Uncheck Financial Management from PMX Prod Template and Commercial Management from PMX Test template
    And I click save button
    Then I check the deployment is successful
    
  #Note: Repeat the scenario 5 to execute the below scenario
  Scenario: 8 Deploy multiple workspaces from different template workspace by removeing one after another
    When I Uncheck Commercial Management from PMX Prod Template
    And I click save button
    And I immediately Uncheck Residential Management from PMX Test Template
    And I click save button
    Then I check the deployment is successful
    
  # This test case is updated
  """
  Scenario: 9 Remove Whole organization worksapace
    When I uncheck all the workspaces from PMX Prod Template
    And click Save button
    Then I check 'Sorry, cannot remove already deployed modules' warning message alert is displayed
  """
  Scenario: 9 Remove Whole organization worksapace when multiple organization workspace present and enabled
    When I uncheck all the workspaces from PMX Prod Template
    And click Save button
    Then I check all the modules of PMX Prod Template is removed and deployment is not triggred
  #("Get Update client Status" run this API in postman to verify the deployment is not triggered)
  
 #Scenario: 10 Can't delete the workspace when active deployment inflight
  # When Add or remove the modules of 'X' (PMX Prod Template) workspace and save changes
  # And Immediately uncheck all the modules of 'X' workspace and save
  # And Hover on cusion(!) icon beside the Modules 
   #Then verify the error message "Can't delete the workspace when active deployment inflight, Try after ({date} {time})"