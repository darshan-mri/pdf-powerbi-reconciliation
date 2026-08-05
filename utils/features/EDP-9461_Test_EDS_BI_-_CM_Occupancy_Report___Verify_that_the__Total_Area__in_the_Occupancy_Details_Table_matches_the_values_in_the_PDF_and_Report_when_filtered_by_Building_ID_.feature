Feature: Greenlaw Commercial Occupancy Report
Scenario: Verify that the “Total Area” in the Occupancy Details Table matches the values in the PDF and Report when filtered by Building ID
  Given User logs into Power BI
  And User selects Workspace
  When User opens the Greenlaw Commercial Occupancy report
  Then User should be able to see the Occupancy Details Table in the report
  And User should be able to select the Building Id from the Filter pane
  When User selects the required Building ID in the Filter Pane
  Then The Total value in Occupancy Details Table for each SuiteID's should be displayed as same as in the PDF
  And the measures using Sq. Ft should be updated as per requirement
  | Keycards  |
  | Occupancy Details Table - Total Area, Occupied Area, Occupancy %, Occupied Area%, Occupied% Prior Year, YTD Absorption  |
  | Absorption  |
  | Lease Changes table - Suite Area Column |