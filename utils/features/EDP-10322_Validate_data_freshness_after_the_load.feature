Scenario: Check data freshness after the load
Given the data load runs on a scheduled basis
When the warehouse is queried after the load
Then the latest records should reflect the most recent data from the source
And timestamps should match the expected load window