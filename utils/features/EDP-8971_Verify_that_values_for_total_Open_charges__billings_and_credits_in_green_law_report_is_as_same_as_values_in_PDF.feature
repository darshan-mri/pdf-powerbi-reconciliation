Feature: Greenlaw AR Insights
Scenario Outline: Verify that values for total Open charges, billings and credits in green law report is as same as values in PDF
Given User logs into Power BI
And user Selects the Workspace
When User Opens the Greenlaw AR Insights report
Then the <Key Cards> values should match with values in the PDF

Examples:
	| Keycards |
	| Total Open Charges |
	| Billings |
	| Credits |