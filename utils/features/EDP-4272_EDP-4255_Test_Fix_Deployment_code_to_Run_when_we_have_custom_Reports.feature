Given I am logged into AIG with the Client ID P123456
When I go to All Items, click on any report and then click the ellipsis in the top right corner
And select Copy as new dashboard, naming it ZZ[ReportName]
And the top left select File and Save 
And at the top right click the ellipsis and Publish

Given I have followed the above, click on any report and then click the ellipsis in the top right corner
And select Copy as new dashboard, naming it ZZZ[ReportName]
And the top left select File and Save (do not publish this report)

Given I am in Postman, in Environments setting ensuring mriClientId is P123456 and deployTemplateWorkspaceId is PMX
When I go to Collections, and click MRI DSG, and select Authorization and at the bottom Get New Access Token 
When your login has been verified under MRI DSG click Proxied, then Post Deploy Reports (Reports only)
And click Send, after a moment below Post Deploy Reports (Report only) click Get Deploy Reports Status
And click Send
And wait a minute and click Send again until the result either provides an error or "Deployment complete - cleanup triggered"

Then the result should be "customStatus": "Deployment complete - cleanup triggered"