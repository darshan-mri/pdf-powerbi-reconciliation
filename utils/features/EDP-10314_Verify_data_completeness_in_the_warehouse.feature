Scenario: Verify data completeness in the warehouse
Given the data is extracted from the source system
When the data is loaded into the warehouse
Then the total number of records in the warehouse should match the expected count
And no records should be missing or duplicated