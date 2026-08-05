Scenario: Validate ambiguity is resolved using merged lease options table
When user adds "CurrentLeaseStatus" from MRI Commercial Leases
And user adds "OptionTypeID" from MRI Commercial Lease Option Types
And user adds "BuildingID" to the visual
Then the visual should load successfully
And user should not see "Can't determine relationships between the fields"
And the visual should display data