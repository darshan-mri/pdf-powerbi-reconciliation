Scenario: Validate Absence of Duplicate Records
 
Given data is loaded into the warehouse
When I check for duplicates based on unique columns
Then there should be no duplicate records