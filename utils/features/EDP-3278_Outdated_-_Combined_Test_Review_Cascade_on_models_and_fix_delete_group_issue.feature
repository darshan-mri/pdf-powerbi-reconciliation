#Tested as part of https://mripride.atlassian.net/browse/EDP-3085
Given I access Agora Insights Gateway  logged into my OktaPreview account
When I click the wrench icon 'Dashboard Management' on the left sidebar

When I click 'Add Item' at the bottom of the page
And name the group TestTemp

When I click Organisation Access
And click the toggle to No on Residential Vacancy, Residential Vacancy Analysis, and Usage Metrics Report
And click save at the bottom
And click the Groups tab of Dashboard management

When I click TestTemp
And I toggle Residential Vacancy Analysis and click Save

When I click Users beside Groups
And select AIG User1
And click the the box to the right of TestTemp
And click Save

When I click Groups in Dashboard Access and select TestTemp
And click the Remove Item icon at the bottom
And confirm Remove
Then TestTemp should be removed