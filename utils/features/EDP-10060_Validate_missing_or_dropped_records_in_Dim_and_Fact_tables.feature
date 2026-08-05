Scenario: Validate missing or dropped records in Dim and Fact tables

Given any Dim or Fact table with multiple records
When the data is loaded into the warehouse
Then the Dim or Fact table should contain all the source records, unless filtered by transformation logic