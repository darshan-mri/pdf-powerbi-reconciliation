Scenario: Validate reference data integrity between Facts and Dims

Given Fact tables referencing Dimension tables
When the data is loaded into the warehouse
Then all foreign keys in Fact tables should map to valid primary keys in the corresponding Dimension tables
And orphaned records should be flagged or excluded from the Fact tables