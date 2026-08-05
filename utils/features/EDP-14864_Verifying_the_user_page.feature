Feature:User Management
  
  Scenario:Verifying the user pages
   
    Given the user logged in as admin 
    And User in the "User Management"page
    When the user is modified from admin to User 
    Then the record should be placed in the user table 
    And only its specified field should be visible
    And only view option should be given