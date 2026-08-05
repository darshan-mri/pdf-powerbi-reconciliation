Scenario: Validate no duplication when combining lease and lease options data
Given user creates a table in the powerbi report
When user adds BuildingID and SuiteID from MRI Commercial Building Suites
And user adds OptionNumber from MRI Commercial Lease Options
And user adds CurrentLeaseStatus from MRI Commercial Leases
And user filters BuildingID = "001684" and SuiteID = "0900"
Then each OptionNumber should appear only once
And total count of OptionNumber should be equal to 3
And no duplicate rows should exist