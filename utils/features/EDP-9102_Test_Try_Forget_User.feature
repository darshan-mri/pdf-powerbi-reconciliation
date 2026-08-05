Feature:Forget user or delete user from tenat(s)
  
  # Tenant = 'AIGDEPLOYAPP' and 'MRIAGORA'
  # Single tenant access
  Scenario:1 Delete a 'AIG.Tester1@mrisoftware.disabled' user who belongs to only one tenant with the help of another user
    Given Puneeth.basavaraju@mrisoftware.com is on 'User security setting' window # you can use any account/user above support role
    When Select 'AIG.Tester1@mrisoftware.disabled' and click 'Delete'
    And Hit delete in prompt
    Then 'AIG.Tester1@mrisoftware.disabled' must be deleted from the UI
    
  Scenario:2 To verify deleted user data is removed from the DB
    When I run these 2 Queries 
    # select * from [dbo].[IdentityPrincipal] where Name='AIG.Tester1@mrisoftware.disabled' --> copy the ID here
    # select * from [dbo].[OrganisationMembership] where userid=''--> Place the ID in the userID
    Then No records should exists
    
  Scenario:3 Delete a 'AIG.Tester1@mrisoftware.disabled' user who belongs to only one tenant with the help of another user,'AIG.Tester1@mrisoftware.disabled' user own's unpublished and draft reports
    # Make sure 'AIG.Tester1@mrisoftware.disabled' own either Unpublished nor draft or both, if not create it 
    When I Select 'AIG.Tester1@mrisoftware.disabled' and click 'Delete'
    And Prompt should appear with the list of unpublished and draft reports
    And Hit delete in prompt
    Then 'AIG.Tester1@mrisoftware.disabled' must be deleted from the UI
    
  Scenario:4 Execute scenario 2
    
  Scenario:5 Delete himself who belongs to only one tenant
    When User 'AIG.Tester1@mrisoftware.disabled' logged in to AIG
    And Select 'AIG.Tester1@mrisoftware.disabled' and click 'Delete' on 'User security setting' window 
    And Hit delete in prompt
    And A warning prompt appear "If you delete this user you will be logged out. Are you sure you want to proceed?"
    And Click OK
    Then 'AIG.Tester1@mrisoftware.disabled' must be deleted from the UI
    
  Scenario:6 Execute scenario 2
    
  Scenario:7 Delete himself who belongs to only one tenant and he own unpublished and draft reports
    # Make sure 'AIG.Tester1@mrisoftware.disabled' own either Unpublished nor draft or both, if not create it
    When User 'AIG.Tester1@mrisoftware.disabled' logged in to AIG
    And Select 'AIG.Tester1@mrisoftware.disabled' and click 'Delete' on 'User security setting' window 
    And Prompt should appear with the list of unpublished and draft reports
    And Hit delete in prompt
    And A warning prompt appear "If you delete this user you will be logged out. Are you sure you want to proceed?"
    And Click OK
    Then 'AIG.Tester1@mrisoftware.disabled' must be deleted from the UI
    
  Scenario:8 Execute scenario 2
    
  Scenario:9 Add back the deleted user to the same tenant
    When I add the deleted user to the same tenant
    Then User should be added to the tenant with viewer role permissions
    
  # Multi tenant access
  # How to verify user is member of multiple tenant --> execute scenario 2 and he should be assigned to morethan 1 tenants
  Scenario:10 Delete 'Aig.user5@mrisoftware.disabled' user in single tenant when he is the member of multiple tenant
    Given Puneeth.basavaraju@mrisoftware.com is on 'User security setting' window # you can use any account/user above support role
    When Select 'Aig.user5@mrisoftware.disabled' and click 'Delete'
    And Hit delete in prompt
    Then 'Aig.user5@mrisoftware.disabled' must be deleted from the UI 
    
  Scenario:11 Execute scenario 2
    
  Scenario:12  Delete 'Aig.user5@mrisoftware.disabled' user in all tenant when he is the member of multiple tenant
    # Repeat the below steps for both tenant AIGDEPLYAPP and MRIAGORA
    Given Puneeth.basavaraju@mrisoftware.com is on 'User security setting' window # you can use any account/user above support role
    When Select 'Aig.user5@mrisoftware.disabled' and click 'Delete'
    And Hit delete in prompt
    Then 'Aig.user5@mrisoftware.disabled' must be deleted from the UI
    
  Scenario:13 Execute scenario 2
    
  Scenario:14 Delete himself from single tenant when he belongs to multiple tenants
    Given Aig.user5@mrisoftware.disabled is on 'User security setting' window # you can use any account/user above support role
    When Select 'Aig.user5@mrisoftware.disabled' and click 'Delete'
    And Hit delete in prompt
    Then 'Aig.user5@mrisoftware.disabled' must be deleted from the UI
    
  Scenario:15 Execute scenario 2
    
  Scenario:16 Delete himself from all tenants when he belongs to multiple tenants
    # Repeat the below steps for both tenant AIGDEPLYAPP and MRIAGORA
    Given Aig.user5@mrisoftware.disabled is on 'User security setting' window # you can use any account/user above support role
    When Select 'Aig.user5@mrisoftware.disabled' and click 'Delete'
    And Hit delete in prompt
    Then 'Aig.user5@mrisoftware.disabled' must be deleted from the UI
    
  Scenario:17 Execute scenario 2
    
  Scenario:18 Delete the 'Aig.user5@mrisoftware.disabled' user from the one of the tenant in which he own Unpublished and darft
    Given Puneeth.basavaraju@mrisoftware.com is on 'User security setting' window # you can use any account/user above support role
    When Select 'Aig.user5@mrisoftware.disabled' and click 'Delete'
    And Prompt should appear with the list of unpublished and draft reports
    And Hit delete in prompt
    Then 'Aig.user5@mrisoftware.disabled' must be deleted from the UI
    
  Scenario:19 Execute scenario 2
    
  Scenario:20 Delete the 'Aig.user5@mrisoftware.disabled' user from the all tenants in which he own Unpublished and darft
    # Repeat the below steps for both tenant AIGDEPLYAPP and MRIAGORA
    Given Puneeth.basavaraju@mrisoftware.com is on 'User security setting' window # you can use any account/user above support role
    When Select 'Aig.user5@mrisoftware.disabled' and click 'Delete'
    And Prompt should appear with the list of unpublished and draft reports
    And Hit delete in prompt
    Then 'Aig.user5@mrisoftware.disabled' must be deleted from the UI
    
  Scenario:21 Execute scenario 2