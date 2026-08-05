Scenario: Validate Exact Field Match

Given the data is loaded from source to warehouse during onboarding
When user compares the fields in both tables
Then the values should match exactly