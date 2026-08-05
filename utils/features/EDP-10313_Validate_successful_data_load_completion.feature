Scenario: Validate successful data load completion
Given a customer is already onboarded and data exists in warehouse 
And the data load pipeline is triggered
When the pipeline execution completes
Then the execution logs should show a successful completion status
And no errors should be recorded in the pipeline logs