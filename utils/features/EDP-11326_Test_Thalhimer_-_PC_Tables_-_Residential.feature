Feature: Validate new fields added to DimPerson in the warehouse

  Scenario: Validate config DB, execute pipeline, and verify warehouse updates for DimPerson
  
  Given the required source tables and fields are configured in the config database
  And the source tables have been ingested into the Data Lake for a customer
  And IsViewReCreate is set to 1 for DimPerson in CustomerProductWHTableList for a customer
  And the following fields should exist in the warehouse DimPerson table
    | FieldName               |
    | ScreeningStatus         |
    | OnlineApplicationStatus |
    | Complete                |
    | AutoScreened            |
    | InviteId                |
    | InvitedToExistingLease  |
    | InvitedAsAddedResident  |
  When I trigger the PIDropAndRecreateCDMViews pipeline for a customer
	And the view "{CustomerName}.vwDimPerson" should be created in Datalake
  When the Azure Synapse pipeline for DimPerson load is triggered
  Then the pipeline should complete successfully
  And the row count in the warehouse DimPerson table should match the source and datalake
  And the values for the following fields in DimPerson should match the source data
    | FieldName               |
    | ScreeningStatus         |
    | OnlineApplicationStatus |
    | Complete                |
    | AutoScreened            |
    | InviteId                |
    | InvitedToExistingLease  |
    | InvitedAsAddedResident  |
	And the data in DimPerson should match the source data