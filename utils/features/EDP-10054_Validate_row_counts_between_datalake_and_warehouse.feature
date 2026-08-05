Scenario: Validate row counts between datalake and warehouse
  
Given customer is onboarded successfully
And the views are created in Datalake
And the Dims and Facts tables are loaded in warehouse
When user checks the counts between Datalake views and warehouse tables
Then the counts should match