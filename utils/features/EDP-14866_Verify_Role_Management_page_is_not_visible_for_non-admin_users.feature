Feature:Role Management
  Scenario:Role Management page is not visible for the non-admin users
    
    Given the user is logged in as user
    And user is the user management page
    When the user clicks on the bottom toggle button
    Then the "Role Management" Page option should not be visibel