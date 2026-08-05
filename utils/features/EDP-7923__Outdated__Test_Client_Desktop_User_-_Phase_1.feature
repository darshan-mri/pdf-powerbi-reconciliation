""" Enhance done on the desktop user role, testcase need to be updated, few testcase are now automated"""
Feature: Create desktopUser custom role
  
  #Note: If there is trouble assigning the role ensure that securityidgroup is in the database, if missing it is 'e25a51b7-6962-404b-bea1-f7eee8ac4686'
  
 #Outdated- Generated automatically Scenario: 1 Inserting desktopUser custom role In Database
    #Note: Confirm if DesktopUser appears in the role table before starting, if it exists move to scenario 2.
  #  Given I open the dev warehouse DB # Server name ="mridevaig01eastus.Database.windows.net", UN & PWD is your credentials
  #  And I insert the following data in to dbo.role table
   # """
  #  insert into [dbo].[Role](Id,Name,Description,IsActive,IsBuiltIn,IsGlobal,TenantKey,LastUpdatedBy,LastUpdatedDate,IsServicePrincipalOnly,SecurityGroupId,SecurityGroupType) 
  #  values ('E0E0DEAA-6B0C-449A-A574-E6E122F0794B','DesktopUser','A desktop user has the same capabilities as a Creator user with additional permissions to access Power BI Desktop related operations, such as downloading drafts and importing a PBIX file.',1,0,0,'AIGDEPLOYAPP','7f000b85-106f-48b4-9698-161e15737957','2024-08-07 14:22:01.4833333',0,'e25a51b7-6962-404b-bea1-f7eee8ac4686','EntraIdSecurityGroup');
  #  """
    # Note : If data is already inserted skip scenario 1
#Then Execute the below Query to cross check the data inserted correctly
    # Select * from dbo.role
    
  Scenario: 2 Check DesktopUser role created In UI
    Given I access AIG web application with clearance to view permissions, TenantKey "AIGDEPLOYAPP" 
    # Note : The client id can be any, but it should the be same as tenantkey which is inserted into the dbo.role table
    And I click gear icon and user security setting link
    And I select the any user in the list and click permissions
    Then Desktop user role should be created along with check box and with a tool top saying "A desktop user has the same capabilities as a Creator user with additional permissions to access Power BI Desktop related operations, such as downloading drafts and importing a PBIX file."
    
  Scenario: 3 Assigning desktop user role to user and check GPS desktop menu availabel in draft
    When I assign desktop user and creator user permissions to "aig.user9@mrisoftware.disabled" # can be assigned to any user
    # Note : if user has only desktop user permission they can't login
    # Note : if Desktop User shows up in the portal, but when applied it gives an error saying security hasn't been setup and synced, it is because the securityid wasn's set to e25a51b7-6962-404b-bea1-f7eee8ac4686 use the below to change that
    #  Update [dbo].[Role] Set SecurityGroupId = 'e25a51b7-6962-404b-bea1-f7eee8ac4686' where id = '<DESKTOP USER ID for that tenant>'
    And login to AIG web application has "aig.user9@mrisoftware.disabled" user with "AIGDEPLOYAPP" client
    And I open 'Residential AR Insight' report
    # choose any report
    And I create a draft
    Then GPS desktop menu should be displayed beside elipses
    
  Scenario 4: GPS desktop menu contain copy workspace name, download & import options
    When I open the draft 
    And click GPS desktop menu
    Then 'Copy workspace name for residential data model','download draft zip' and 'Import pbix' options should be displayed and enabled
    
  Scenario 5: All 3 options in GPS desktop menu are grayed in draft edit mode
    When I open the draft
    And I click elipses and edit draft button
    And I click GPS desktop menu 
    Then 'Copy workspace name for residential data model','download draft zip' and 'Import pbix' options should be drayed
    
  Scenario 6: Check security group is added to the dataset workspace
    When I open the draft 
    And I Open the GPS desktop menu 
    And I click 'Copy workspace name for <name of the data model> data model'
    And Open new tab search "https://app.powerbi.com"
    And On left bottom of the screen click on workspaces and paste the workspace name
    And On right side top click on manage access
    Then 'sg.365.pbi.dataset.aig.demo.admin' group name should be displayed along with 'Viewer' permissions