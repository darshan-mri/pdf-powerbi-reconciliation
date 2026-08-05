Scenario: Check referential integrity between Facts and Dims
Given the warehouse has Fact and Dimension tables
When the data is loaded into the warehouse
Then all foreign keys in the Fact tables should reference valid primary keys in Dimension tables
And orphaned records should not exist in Fact tables