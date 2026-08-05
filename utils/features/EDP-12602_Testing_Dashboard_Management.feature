#Relevant comments and explanations appear below the line, or above a block, preceded by #
#An OktaPreview account is required

Scenario: 1 Default page load
Given I access Agora Insights Gateway  logged into my OktaPreview account
When I click the wrench icon 'Dashboard Management' on the left sidebar
Then the page brought up will be the Groups tab of Dashboard Management

Scenario: 2 Add group
When I click 'Add Item' at the bottom of the page
And name the group TestTemp
Then TestTemp should appear on the list

Scenario: 3 Confirm unique names
When I click 'Add Item' at the bottom of the page
And name the group TestTemp (or whatever was used in the previous scenario)
Then an error should appear saying the name must be unique and the Create button will be disabled

Scenario: 4 Confirm available options
#If all access options on the right are greyed out it means access is controlled by the Organisation Access and must be changed.
#If there are options that are not greyed out ensure that there are at least three, two of which have the same word somewhere in their name. e.g. Residential Vacancy and Residential Vacancy Analysis
#If there are three such selectable options go three blocks down to 'When I toggle Residential' otherwise follow below to enable them
When I click Organisation Access
And click the toggle to No on Residential Vacancy, Residential Vacancy Analysis, and Usage Metrics Report
#The exact access does not matter, only that two of the three share a common word to filter by
Then a Save / Cancel option should appear at the bottom of the page [Do not click]
When I click the TestTemp group
Then a warning should appear notifying about unsaved data

Scenario: 5 Persistent disabled state
When I click cancel in the warning
And click save at the bottom
And return to the Home Screen via the Home button
And click the Groups tab of Dashboard management
Then the three access options that were disabled from Organisation Access should remain disabled

Scenario: 6 Confirm available options for
When I click TestTemp
Then the three access options should not be greyed out, and be togglable 

Scenario: 7 Verify Save/Cancel prompt
When I toggle Residential Vacancy Analysis
#Or whatever option that shares a word with another option
Then a Save/Cancel prompt should appear at the bottom of the page

Scenario: 8 Verify unsaved changes warning
When I click the Users tab in the top left
Then a warning should appear notifying about unsaved data

Scenario: 9 Verify filter
When I click cancel on the warning
And put in 'vacancy' in the filter input
#Again, can be whatever option has a shared word in the title
Then it should return those two options, and possibly any other with that same keyword

Scenario: 10 Verify Select All
When I click the select all box to the left of the Dashboard header
Then both options should be highlighted
When I click either option
Then it should toggle to match its partner
When I click again
Then both options should toggle in unison

Scenario: 11 Persistent disabled state on user
When I turn both options to Yes
And click save
And navigate to another screen
And click back to Dashboard Access, TestTemp
Then the two matching access options from about should be enabled and the third one disabled

Scenario: 12 Verify Select All
When I click Users beside Groups
And select AIG User1
#Any testing or personal account can be used
And click the select all box beside Names
Then it should select the TestTemp option as well as any other existing option, if any

Scenario: 13 Verify access source
When I click off select all
And click the box below Member
And in the dashboard options to the right click Usage Metrics Report
#Or whatever option does not have the matching name
Then it should bring up a Save/Cancel prompt
Then to the right of the dashboard access should be an icon. For the two matching options it should be an icon of two people and if hovered over it should say "Access via TestTemp group". To the right of the single selected option there should be an icon of a single person and if hovered over it should say "Access via user"

Scenario: 14 Persistent access
When I click save, and navigate to a random user, and return to AIG User1
Then the three access options should all say 'Yes' regarding access

Scenario: 15 Verify access removal
When I click the checkmark under member to remove the user from the group
Then the matching access options should disable, and the individual option stay selected

Scenario: 16 Deep linking
When I click save, and then copy the full URL
And navigate to the home screen
And paste the URL back into the browser and hit enter
Then it should return to the page for AIG User1 and the single access option should be enabled and the matching options disabled

Scenario: 17 Reenable
When I click Groups in Dashboard access, and select Organisation Access
Then the three tested access options should all be disabled
When I click the 'Select all' button beside Dashboards
And click any of the disabled options, they should all become enabled
#Note: at this time all options are active for Organisation Access. If at any point one or more is disabled in default, then skip this step as you do not want to accidentally activate another access. In such a case just manually enable the three options]
And click save

When I click TestTemp
And click the Remove Item icon at the bottom
And confirm Remove
Then TestTemp should be removed
#The entirity of these steps ensures that all data has been returned to its original state 

#Right click, select Inspect, go to the top left to Dimensions, select Samsung Galaxy S20 Ultra [Any phone can work really, this one is just a bit larger and easier to navigate]
#Repeat in mobile view