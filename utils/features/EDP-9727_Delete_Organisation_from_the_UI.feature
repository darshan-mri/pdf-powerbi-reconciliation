Feature: Delete Organisation from the UI
  
  Scenario:1 Delete button should be disable
    Given User login to AIG application with System admin or Global service permission
    When onboard new Client 
    And navigate to Client onboard configuration
    Then verify Delete button is disabled
    
  Scenario:2 Delete button should be enabled
    When Deployment is triggred 
    Then verify Delete button should be enabled
    
  Scenario:3 'Confirm Delete' prompt popup
    When I click on Delete button
    Then verify the 'Confirm Delete' prompt popup
    
  Scenario:4 Content in 'Confirm Delete' prompt
    When I click on Delete button
    Then verify Client Name is correct and Delete button should be disabled and Cancel button should be enabled.
   
  Scenario:5 Delete button behavior with Invalid client name
    When I enter the invalid client name # text is case sencitive and Space sencitive
    Then Delete button should be disabled
    
  Scenario:6 Delete button behavior with valid client name
    When I enter the valid client name # text is case sencitive and Space sencitive
    Then Delete button should be enabled and clickable
    
  Scenario:7 Delete the organization with active deployment inflight
    When Delete the Organization before the cleanUp
    Then Deletion for organization should be rejected with following error message
    "Cannot delete an Organisation when there is an active deployment inflight, Try after('MM/DD/YYYY HH:MM:SS')"
    
  Scenario:8 Successful deletion of organization
    When organization deletion is successful
    Then