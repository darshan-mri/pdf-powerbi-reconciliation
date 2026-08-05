Feature: Bookmark functionality
  
  Scenario: 1 Validate standard reports, custom reports & draft contains bookmark
    Given I access AIG web application
    When I open standard report, custom report and draft one by one # if custom or draft doen't exist, create one
    Then I check on right side top bookmark icon exist
    
  Scenario: 2 Validate Unpublished reports doesn't contains bookmark
    Given I access AIG web application
    When I open Unpublished report # if doen't exist, create one
    Then I check on top right side bookmark icon doesn't exist
    
  Scenario: 3 Validate bookmark set on report level
    When I open 'Commercial AR Insight' report # any report is fine
    And I click on the bookmak on top right corner
    And I click 'ADD Bookmark' and name the bookmark as 'My Bookmark'
    And I click createbookmark button
    And I check the bookmark created in the bookmark list
    When I open the another report 'Commercial AR pattern'
    And I click Bookmark icon
    Then I check 'My Bookmark' doesn't exist
    
  Scenario: 4 Validate bookmark contains 'Add Bookmark'
    When I open any standard report
    And I click bookmark icon on top right side corner
    Then I check '+ Add Bookmark' option exist
    
  Scenario: 5 Create a Bookmark
    When I open the 'Commercial AR Insights' report
    And I click '+ Add Bookmark' 
    And I name the bookmark as 'My 1st Bookmark'
    And I click createbookmark button
    And I click bookmark icon
    Then I check 'My 1st Bookmark' is created
    
  Scenario: 6 Validate bookmark has these 5 options(Make Default, Apply, Rename, Update, Delete)
    # continuation of scenario 5
    When I mouse hover on 'My 1st Bookmark' bookmark
    Then I check Make Default, Apply, Rename, Update and Delete options are exist
    
  Scenario: 7 Apply Bookmark
    # continuation of scenario 6
    When I click on Apply option
    Then I check bookmark is applied on the report
    
  Scenario: 8 Rename the bookmark
     # continuation of scenario 6
    When I click on Rename option
    And I update the name to 'My New Bookmark'
    And I click Rename Bookmark button
    And I click bookmark icon
    Then I check Bookmark renamed to 'My New Bookmark'
    
  Scenario: 9 Update the bookmark
    When I do some changes in the report, Ex: I will change the date in Date filter
    And I navigate to 'My New Bookmark'
    And I click update option
    Then I check the changes are updated in 'My New Bookmark'
    
    Scenario: 10 Set bookmark as default
    When I Navigate to the 'My New Bookmark' bookmark
    And I click on 'Make Default'
    Then I check 'My New Bookmark' bookmark is applied when ever the report is opened
    # also check (default) text displayed beside the 'My New Bookmark'  ex: 'My New Bookmark(default)'
    
  Scenario: 11 Delete the bookmark
    When I Navigate to the 'My New Bookmark' bookmark
    And I click on delete
    Then I check 'My New Bookmark' bookmark is deleted from the list
    
    Scenario:12 Drafts should contains the bookmarks of its parent report(custom report)
    When I open any custom report
    And I create a New bookmark and name it to 'Test 1'
    When I create the new Draft and save it
    Then I check that draft contain the 'Test 1' bookmark
    
  Scenario:13 Custom reports should not contains the bookmark of it's parent report(Standard report)
    When I open any of the standard report 
    And I create a New bookmark and name it to 'Test 2'
    When I create the new custom report and save it
    Then I check that custom report doesn't contain the 'Test 2' bookmark
    
  Scenario:14 On hiding concept standard report should retain it's bookmarks after deletion of custom report
    When I open any of the standard report 
    And I create a New bookmark and name it to 'Test 3'
    When I create the new custom report and publish as 'Replacement Dashboard'
    And I delete the custom report
    Then I check the standard report retain it's bookmark 'Test 3'
    
  Scenario:15 Verify bookmark accessibility across users roles for a single client
    Given I login as 'aig.user6@mrisoftware.disabled' with 'Client Administrator' permission
    When I open 'Commercial AR Insight' report and create bookmark and name it as 'Test 4' # Any report is fine
    And I logout
    When I login as 'aig.user9@mrisoftware.disabled' with 'Viewer user' permission
    And I open the 'Commercial AR Insight' report
    Then I check it contain bookmark 'Test 4'