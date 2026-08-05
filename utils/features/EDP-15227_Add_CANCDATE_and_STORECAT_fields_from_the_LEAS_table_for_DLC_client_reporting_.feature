Feature: CancelDate field added to the FactCommercialLeases table in warehouse

   Scenario: Add ClosedDate column and load data
     Given the column CancelDate exists in the Config DB mapping for FactCommercialLeases
     And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactCommercialLeases
     And the CancelDate column values should be NULL for FactCommercialLeases in warehouse
     When the PiDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
     And the PiFactCommercialLeases pipeline is triggered in Azure Synapse
     And the pipeline execution is completed successfully
     Then the column CancelDate should have data loaded in the warehouse table FactCommercialLeases
     And the data in FactCommercialLeases should match across datalake and warehouse