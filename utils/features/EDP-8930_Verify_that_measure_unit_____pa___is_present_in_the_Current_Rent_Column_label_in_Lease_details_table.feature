Feature: Lease Details Table - Asset Modelling
Scenario Outline: Verify that measure unit '($/pa)' is present in the Current Rent Column label in Lease details table
Given User logs into Power BI
And user selects the Workspace
When User Opens the Asset Modelling report
Then the table headers along with proper data should be loaded in Lease Details Table
When User selects any of the records from the table
Then the information related to the selected record should be displayed in Lease Expiration Units and Expiry Banding visuals pie chart
And Measure Unit '($/pa)' should be present in the Current Rent Column label in Lease details table