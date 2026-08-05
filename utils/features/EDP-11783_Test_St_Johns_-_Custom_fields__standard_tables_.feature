Feature: Validate CustomFields added to DimCommercialLeases, DimCommercialBuildingSuites and DimEntities in the warehouse

Scenario: Validate config DB, execute pipeline, and verify warehouse updates for DimCommercialLeases
  
  Given the required source tables and fields are configured in the config database
  And the source tables have been ingested into the Data Lake for a customer
  When I trigger the PIDropAndRecreateCDMViews pipeline for a customer
  And the view "{CustomerName}.vwDimCommercialLeases" should be created in Datalake
  When the Azure Synapse pipeline for DimCommercialLeases load is triggered
  Then the pipeline should complete successfully
  And the row count in the warehouse DimCommercialLeases table should match the Source and datalake
  And the values for the following fields in DimCommercialLeases should match the datalake data
    | ParentName           |
    | BillingContact       |
    | BillingPhone         |
    | EmergencyContact1    |
    | EmergencyPhone1      |
    | EmergencyContact2    |
    | EmergencyPhone2      |
    | WebAddress           |
	  | FaxNumber            |
	  | AttachmentId         |
	  | OnsiteEmail          |
  	| Service              |
	  | OnsiteContact        |
	  | OnsitePhoneNumber    |
	  | Source               |
	  | Reasonforleaving     |
	  | EnergyStarUseCode1   |
	  | EnergyStarUseCode2   |
	  | EnergyStarUseCode3   |
	  | EnergyStarSqft1      |
	  | EnergyStarSqft2      |
	  | EnergyStarSqft3      |
	  | BillingContact2      |
	  | BillingPhone2        |
	  | BillingEmailAddress2 |
	  | OnsiteContact2       |
	  | OnsitePhoneNumber2   |
	  | HVACExpirationDate   |
  And the data in DimCommercialLeases should match with Datalake and warehouse
	
Scenario: Validate config DB, execute pipeline, and verify warehouse updates for DimCommercialBuildingSuites

Given the required source tables and fields are configured in the config database
  And the source tables have been ingested into the Data Lake for a customer
  When I trigger the PIDropAndRecreateCDMViews pipeline for a customer
  And the view "{CustomerName}.vwDimCommercialBuildingSuites" should be created in Datalake
  When the Azure Synapse pipeline for DimCommercialBuildingSuites load is triggered
  Then the pipeline should complete successfully
  And the row count in the warehouse DimCommercialBuildingSuites table should match the Source and datalake
  And the values for the following fields in DimCommercialBuildingSuites should match the datalake data
    | AttachmentId       |
    | BuildingParkID     |
	  | BuildingTypeID     |
	  | LeasingAgent       |
	  | BuildingEngineerID |
	  | Region             |
	  | OwnerEntity        |
	  | BuildingRegionID   |
   And the data in DimCommercialBuildingSuites should match with Datalake and warehouse

Scenario: Validate config DB, execute pipeline, and verify warehouse updates for DimEntities

Given the required source tables and fields are configured in the config database
  And the source tables have been ingested into the Data Lake for a customer
  When I trigger the PIDropAndRecreateCDMViews pipeline for a customer
  And the view "{CustomerName}.vwDimEntities" should be created in Datalake
  When the Azure Synapse pipeline for DimEntities load is triggered
  Then the pipeline should complete successfully
  And the row count in the warehouse DimEntities table should match the Source and datalake
  And the values for the following fields in DimEntities should match the datalake data
    | MultipleBuildings      |
    | RealEstateTaxesPSF     |
	  | EASPercentageinEntity  |
	  | RentPSF                |
	  | VacancyPSF             |
	  | OtherIncomePSF         |
	  | ManagementFeePSF       |
	  | Maint_Rep_TIPSF        |
	  | InsurancePSF           |
	  | EntityNotes            |
	  | ResponsibleLocation    |
	  | LoanID                 |
	  | DebtMaturityDate       |
	  | ShellCompleteDate      |
   And the data in DimEntities should match with Datalake and warehouse