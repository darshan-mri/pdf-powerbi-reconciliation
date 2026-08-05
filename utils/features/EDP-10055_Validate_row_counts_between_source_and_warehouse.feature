Scenario: Validate row counts between source and warehouse
  
Given customer is onboarded successfully
And the Dims and Facts tables are loaded in warehouse
When user checks the counts between source tables and warehouse tables
Then the counts should match