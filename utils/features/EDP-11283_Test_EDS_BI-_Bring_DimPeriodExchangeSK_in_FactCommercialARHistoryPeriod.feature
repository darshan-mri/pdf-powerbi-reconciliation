Feature: Validate newly added column DimPeriodExchangeSK for FactCommercialLedger and FactCommercialARHistoryPeriod tables in Warehouse

  Scenario: Validate DimPeriodExchangeSK integration in FactCommercialLedger pipeline
    Given the column DimPeriodExchangeSK exists in the Config DB mapping for FactCommercialLedger
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactCommercialLedger
    And the DimPeriodExchangeSK column values should be NULL for FactCommercialLedger in warehouse
    When the PIDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the FactCommercialLedger pipeline is triggered in Azure Synapse
    And the pipeline execution is completed successfully
    Then the column DimPeriodExchangeSK should have data loaded in the warehouse table FactCommercialLedger
    And the column values of DimPeriodExchangeSK in FactCommercialLedger should match with the values of column DimPeriodExchangeSK in DimPeriodExchange
    And the number of records in FactCommercialLedger should match across source, datalake and warehouse
    And the data in FactCommercialLedger should match across source, datalake and warehouse

  Scenario: Validate DimPeriodExchangeSK integration in FactCommercialARHistoryPeriod pipeline
    Given the column DimPeriodExchangeSK exists in the Config DB mapping for FactCommercialARHistoryPeriod
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactCommercialARHistoryPeriod
    And the DimPeriodExchangeSK column values should be NULL for FactCommercialARHistoryPeriod in warehouse
    When the PIDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the FactCommercialARHistoryPeriod pipeline is triggered in Azure Synapse
    And the pipeline execution is completed successfully
    Then the column DimPeriodExchangeSK should have data loaded in the warehouse table FactCommercialARHistoryPeriod
    And the column values of DimPeriodExchangeSK in FactCommercialARHistoryPeriod should match with the values of column  DimPeriodExchangeSK in DimPeriodExchange
    And the number of records in FactCommercialARHistoryPeriod should match across source, datalake, and warehouse
    And the data in FactCommercialARHistoryPeriod should match across source, datalake, and warehouse

  Scenario: Insert new records for DimPeriodExchange in source and validate data propagation to warehouse
    Given a set of new records with valid values are inserted for DimPeriodExchange into the source system for FactCommercialLedger and FactCommercialARHistoryPeriod
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for DimPeriodExchange, FactCommercialLedger, and FactCommercialARHistoryPeriod
    When the pipelines PlTablewiseChecksumLoad, PlMasterStagingDataLoad, PlMasterDynamicExternalCreation, PlMasterTransformDataLoad and PlMasterDynamicExternalCreationTransform are triggered in Azure Synapse
    And the pipeline executions are completed successfully
    Then the view "{CustomerName}.vwDimPeriodExchange" should include the newly inserted source records
    When the DimPeriodExchange pipeline is triggered in Azure Synapse
    And the FactCommercialLedger and FactCommercialARHistoryPeriod pipelines are triggered in Azure Synapse
    And all pipeline executions complete successfully
    Then the newly inserted records along with the generated DimPeriodExchangeSK should be present in the DimPeriodExchange table in the warehouse
    And the corresponding DimPeriodExchangeSK values should be populated in the FactCommercialLedger table in the warehouse
    And the corresponding DimPeriodExchangeSK values should be populated in the FactCommercialARHistoryPeriod table in the warehouse
    And the inserted data should match between source, data lake and warehouse for DimPeriodExchange, FactCommercialLedger, and FactCommercialARHistoryPeriod