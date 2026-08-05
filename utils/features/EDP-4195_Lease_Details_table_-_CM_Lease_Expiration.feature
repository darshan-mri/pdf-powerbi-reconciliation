Feature: Commercial Lease Expiration Report
Scenario: User interacts with the Lease Expiration Table
  Given the user is logged into PowerBI
  And has selected the appropriate workspace
  When the user opens the "Commercial Lease Expiration" report
  Then the "Lease Details" table should display headers and corresponding data
  And the following Column Names should be available in table:
    #Group by Column Names
    | Expiration Date |
    | Building Name   |
    | Suite ID        |
    
    #Other Column Names
    | Lease ID              |
    | Total Sq. Ft          |
    | Monthly Rent          |
    | Monthly Rent PSF      |
    | Monthly Other Income  |
    | Expiration Band       |
  
  When the user selects a record from the "Lease Details" table
  Then the related information should be reflected in the "Lease Expiration Units" and "Expiry Banding" pie charts
  And the expiration date in the "Lease Details" table should match the date shown in the "Lease Expiration Units" visual