Scenario: Validate no duplication at warehouse when joining lease and lease options
When user joins FactCommercialLeaseOptions and FactCommercialLeases using lease key
Then each OptionNumber should have exactly one record per lease
And duplicate count should be zero