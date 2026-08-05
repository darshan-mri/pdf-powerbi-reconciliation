Feature: Integration API - User impersonation
  
  """ Navigation steps
  Postman--> MRI AIG Integration--> Integration API--> Reports--> Get List Reports by User - filtered,paged,ordered, and Projected
  """
  
  """Environment setup
  Environments--> MRI AIG Int - dev--> tokenClientSecret--> copy the 2nd link in 'initial value'--> search in chrome and get the secret id
  --> paste it in current value column of tokenClientSecret--> click Save --> and set active
   ClientID=AIGDEPLOYAPP
  """
  
  """Authentication
  MRI AIG Integration--> Authorization--> click Get New Access Token--> proceed--> Use Token
  """
  # Make sure to have few unpublished and draft and custom reports in the tenant
  Scenario:1 Verify that the API fetches only standard and custom report details in the response.
    Given I Access postman
    When I open the 'Get List Reports by User - filtered,paged,ordered, and Projected' endpoint
    And Enter the user email in the route Ex:{{baseUrl}}/api/internal/users/aig.user9@mrisoftware.disabled/reports # Note:- user should the member of that tenant
    And Hit send button
    Then Verify the all the standard and custom reports are loaded
  # How to verify--> if 'Iscustom=false' then it is standard report, else 'IsCustom=true' and 'isPublished=true' then it is custom report, if 'Iscustom=false' and 'isPublished=false' then it is draft or unpublished report(Draft & unpublished reports should not be loaded)
  
  Scenario:2 verify respnce code 200 for valid user
    When I enter the valid user email in the route
    And Hit send
    Then verify 200 response code
    
  Scenario:3 verify response code 403 for invalid user
    When I enter the invalid user email in the route
    And Hit send
    Then verify 403 response code
    
  Scenario:4 Verify standard and custom report in API Response contains or matches with AIG Portal reports
    # Continuation of scenario 2
    When I enter the valid user email in the route # aig.user9@mrisoftware.disabled
    And Hit send and I get list of custom and standard reports in responce
    When I login to AIG Portal as 'aig.user9@mrisoftware.disabled'
    Then verify the API respoce reports and portal reports are same
    
 # Outdated 
 #Scenario:5 Add impersonation header
  #  When I insert new header 'X-Current-MriUserId = aig.user10@mrisoftware.disabled'
  #  And I Insert 'aig.user9@mrisoftware.disabled' in the route
  #  And Execute the API
 #   Then verify in responce, The value in the route override the header value
    
##Scenario:6 Service principal to access only authourized Template workspace
    """
    Server  : mridevaig01eastus.Database.windows.net
    DB      : mridevaig01
    
    $$$$$$$ Run the below Query to cancel access on all tenants $$$$$$
    Update IdentityPrincipal set CanAccessAllTenants = 0 where  Id = '5A0621FA-8DEB-4E7A-B318-8CD2FF12F420'
    
    $$$$$$$ Run the below Query to provide service principal access on PMX product( $$$$$$
    Update TemplateWorkspace set AuthorizedServicePrincipalId = '5A0621FA-8DEB-4E7A-B318-8CD2FF12F420' where Name = 'PMX' 
    """
    #Note: Make sure portal application contain PMX Prod Template & PMX Test Template, And also make sure PMX Prod templare contain CM module and PMX Test template contain FM module for easier validation
   # When I run the above 2 Queries
  #  And I execute 'Get List Reports by User - filtered,paged,ordered, and Projected' endpoint
   # Then Verify the response contains all custom and standard reports from the CM module of the PMX Prod Template.
    
   # $$$$$$$ Run the below Queries to return access to previous state $$$$$$
   #   Update IdentityPrincipal set CanAccessAllTenants = 1 where  Id = '5A0621FA-8DEB-4E7A-B318-8CD2FF12F420'
   #     Update TemplateWorkspace set AuthorizedServicePrincipalId = NULL where Name = 'PMX'