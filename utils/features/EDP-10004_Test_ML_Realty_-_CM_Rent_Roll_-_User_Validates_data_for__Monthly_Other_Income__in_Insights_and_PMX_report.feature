Scenario: User Validates data for 'Monthly Other Income' in Insights and PMX report
Given User logs into PowerBI
And User selects the appropriate WorkSpace
When User Opens MLRealty Rent Roll Report
Then ensure all visuals in the report display without any null values
And  verify that the ‘Monthly Other Income’ field in the Rent Roll Table and the totals match the values in the PDF.