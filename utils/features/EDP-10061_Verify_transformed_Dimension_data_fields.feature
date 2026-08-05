Scenario: Verify transformed Dimension data fields

Given data transformation rules are defined for Dimension tables
When the data is loaded into the warehouse
Then each transformed field in the Dimension tables should match the expected output format and value
And surrogate keys should be correctly generated and mapped