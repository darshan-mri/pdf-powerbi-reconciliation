Scenario: Verify schema consistency in the warehouse
Given the schema is defined for the warehouse tables
When data is loaded into the warehouse
Then the data types of all columns should match the schema definition
And no unexpected null values should exist in mandatory fields