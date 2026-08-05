Feature: Verify Location ID with Description in PowerBI and Warehouse

  Scenario: User verifies Location ID with Description in PowerBI and Warehouse
    Given User logs into PowerBI
    And User selects the Workspace
    And User opens the Thalhimer Report
    When User clicks on the Edit menu option
    And User clicks on the Table icon in the Visualization section
    And User clicks on the Location ID - Description column from the Data section
    Then Location ID with Description should be populated in the Table
    And User logs into the Warehouse
    And User enters the following query:
      """
      SELECT DISTINCT Location, LocationID 
      FROM MRI.DimEntities 
      WHERE MRICLientID = 'k466999' 
        AND IsCurrentRow = 1 
        AND Location IS NOT NULL;
      """
    Then the same data should be displayed in both the report and Warehouse