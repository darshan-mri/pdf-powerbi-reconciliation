Scenario Outline: Verify that NOI Variances% has been removed in NOI YTD Keycard and Hub details table
Given User logs into Power BI
And User selects the workspace
When User Opens the Lightstone Financial Hub Map report
Then NOI Variances% value should not display in NOI YTD Keycard
And NOI Variances% column should not present in Hub details table