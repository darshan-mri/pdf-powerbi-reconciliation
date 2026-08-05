Scenario: Validate incremental data load
Given the data load is incremental
When new records are added in the source
Then only new or updated records should be inserted into the warehouse
And historical records should not be duplicated