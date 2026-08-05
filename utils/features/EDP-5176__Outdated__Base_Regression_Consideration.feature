##These functions are tested through other tests. These can be run separately or through other test.
##Test is written for dev and AIGDEPLOYAPP, replace with whatever environment and clientid you are working with.

Given I'm logged into https://dev-mriagorainsights.redmz.mrisoftware.com/ client ID AIGDEPLOYAPP with an account capable of making new dashboards
When I select a report and click the ellipsis in the top right corner selecting Copy as a new dashboard
And I name the report Z[Report] and click Create Dashboard
And I click File to the top left of the report and Save
And I click the ellipsis again selecting Publish draft
And a pop-up appears and I select New dashboard and publish dashboard
Then the new dashboard will be published

When I repeat the above instructions naming the report ZZ[Report], but only saving it, not publishing it
Then a draft version will appear in the report list

Given I've opened Postman, and on the left have selected Environments, and picked MRI DSG - dev by clicking the checkmark to the right of the name
And I make sure the Current Value of mriClientId is AIGDEPLOYAPP
When I select Collections to the left again selecting MRI DSG, click Authorization and at the bottom authorize your account
And under Proxied select Post Deploy Reports, and send at the top right ##On the second run of this test select Post Deploy Reports (Reports Only)
And after waiting a few minutes select Get Deploy Reports Status and hit send, if it says it has completed move on, otherwise wait and repeat in a few minutes until it says it is completed
When I return to AIG dev, refresh the page #If an error shows open a new browser and access it through there
And I look down the list of all reports
Then at the bottom it should show Z[Report] and ZZ[Report] (Draft)