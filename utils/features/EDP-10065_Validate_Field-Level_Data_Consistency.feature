Scenario: Validate Field-Level Data Consistency
  
Given the data is loaded from source to warehouse during onboarding
And a record with same ID exists in both source and warehouse tables
When user retrieves the record data
Then all the fields should match exactly
And validate the fields for different records randomly