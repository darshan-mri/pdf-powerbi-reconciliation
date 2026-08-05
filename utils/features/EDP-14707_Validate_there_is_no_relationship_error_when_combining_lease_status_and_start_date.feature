Scenario: Validate visual does not break when combining fields from two fact tables
When user adds "CurrentLeaseStatus" from MRI Commercial Leases
And user adds "StartDate" from MRI Commercial Lease Options
And user adds "BuildingID" to the visual
Then the visual should load successfully
And user should not see "Can't determine relationships between the fields"
And the visual should display data