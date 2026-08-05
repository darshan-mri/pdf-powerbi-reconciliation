Scenario: Validate customer onboarding
  
Given customer onboarding data is present in the source database
And the OnBoardingDetails.csv file is updated with the customer details that is being onboarded in the onboarding container
And the onboarding is triggered by updating and saving the Customer-onboarding.txt file
When the onboarding pipelines are executed
Then all customer records should be processed without errors
And any failed records should be moved to error records
And onboarding statuses should be accurately reflected in the config database, Datalake and Warehouse database