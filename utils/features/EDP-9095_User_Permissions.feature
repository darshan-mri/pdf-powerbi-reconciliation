Feature: User permissions behavior
  
  # Operate with System Admin role
  Scenario:1 To verify User permissions page contains list of 8 items
    Given: Access to AIG web application
    And Navigate to 'Admin Settings' -> 'User security setting'
    When I open the permissions tab of any user
    Then These 8 items should be listed 
    # Client Administrator, System Administrator, Global services user, Support user, Viewer user, Creator user, Dataset maintainer, Desktop user
    
  Scenario:2 To verify the each user permissions are enabled
    When I check each individual user permissions and hit save
    Then Check box should be checked
    
  Scenario:3 To verify the each user permissions are disabled
    When I Uncheck each individual user permissions and hit save
    Then Check box should be checked
    
  Scenario:4 To verify each user permissions contains tool tip text
    When I mouse hover on the tooltip icon exist next to each user role
    Then Expected tooltip text should appear
    # Client Administrator  - A client administrator has permissions to manage dashboards, user access and permissions. Manage user groups, group memberships, dashboard access. Add and remove users and set roles and permissions.
    # System Administrator  - A System administrator has full permission to manage dashboards and user access. Manage dashboard deployments and onboard new clients.
    # Global services user  - A Global Services user has permissions to manage dashboards, user access and permissions. Manage dashboard deployments and onboard new clients.
    # Support user          - A Support user has permissions to manage dashboards, user access and permissions. This user can access multiple client accounts.
    # Viewer user           - A viewer user has permissions to interact with dashboards, apply filters, set dashboards as default or favorite, but cannot edit or modify the dashboard
    # Creator user          - A creator user has permissions to create and edit dashboards. They can customize data visualizations, data points, filters, configure the dashboard's settings and data sources. Creators are responsible for designing and maintaining the dashboard.
    # Dataset maintainer    - A Dataset maintainer has permissions to view datasets and related metadata and perform adhoc refresh
    # Desktop user          - A desktop user has the same capabilities as a Creator user with additional permissions to access Power BI Desktop related operations, such as downloading drafts and importing a PBIX file.
    
  Scenario:5 To verify the prompt with unsaved changes
    When I do some changes in user permissions # remove or add role
    And Don't click save or cancel button
    And Try switching to another user(s) or tabs (Dashboards,Dashboard Access etc...)
    Then prompt should appear saying "You have unsaved data, are you sure you want to continue?" with Ok and cancel buttons
    
  Scenario:6 Accept the prompt
    When I click 'OK' button
    Then Successfully navigate to the selected option, and any unsaved changes should be undone
    
  Scenario:7 Reject the prompt
    When I click 'Cancel' button
    Then User stays on same page with unsaved changes