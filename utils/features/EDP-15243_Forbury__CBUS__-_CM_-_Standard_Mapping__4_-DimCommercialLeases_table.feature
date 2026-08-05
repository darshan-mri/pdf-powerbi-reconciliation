Feature: Validate newly added column for DimCommercialLeases table in dev Warehouse

  Scenario: Validate added column integration in DimCommercialLeases pipeline
     Given the newly added column exists in the Config DB mapping for DimCommercialLeases
     And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for DimCommercialLeases
     And the newly added column values should be NULL for DimCommercialLeases in warehouse
     When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
     And the PlDimCommercialLeases pipeline is triggered in Azure Synapse
     And the pipeline execution is completed successfully
     And the below following columns are added into the table
       |TenantID|
       |ChainId|
       |ChainName|
       |LastDate|  	 
     Then the all newly added column should have data loaded in the warehouse table DimCommercialLeases
     And the number of records in DimCommercialLeases should match across datalake and warehouse
     And the data in DimCommercialLeases should match across datalake and warehouse