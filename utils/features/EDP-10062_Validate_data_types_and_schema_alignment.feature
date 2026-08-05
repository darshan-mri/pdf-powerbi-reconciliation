Scenario: Validate data types and schema alignment

Given source and warehouse schema definitions
When the pipeline completes the load
Then the warehouse schema should match the defined schema, including data types and constraints for both Fact and Dimension tables
And columns should not have unexpected nulls or incorrect data types