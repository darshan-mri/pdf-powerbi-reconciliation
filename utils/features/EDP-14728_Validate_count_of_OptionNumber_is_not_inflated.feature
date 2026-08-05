Scenario: Validate count of OptionNumber is not inflated
When user calculates count of OptionNumber for specific BuildingID and SuiteID
Then the count should not exceed expected number of options