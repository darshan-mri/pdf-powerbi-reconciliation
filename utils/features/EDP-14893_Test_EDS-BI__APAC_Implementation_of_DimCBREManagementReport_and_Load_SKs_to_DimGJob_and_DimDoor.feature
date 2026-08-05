Feature: Validate creation and structure of DimCBREManagementReport Dimention table	

  Scenario: Validate DimCBREManagementReport table structure
    Given the table DimCBREManagementReport exists in warehouse
    And the table DimCBREManagementReport contains the fields as per the mapping document
    And the column DimCBREManagementReportSK is defined as a surrogate key and set as primary key
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for DimCBREManagementReport
    When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PlCMDimensionMaster pipeline is triggered in Azure Synapse
    And all pipeline executions complete successfully
    Then the CDM view for DimCBREManagementReport should be recreated successfully in datalake
    And the view in datalake should include all columns defined in the mapping document with the data loaded
    And the number of records in DimCBREManagementReport should match across datalake and warehouse
    And the data in DimCBREManagementReport should match across datalake and warehouse 
	
Feature: Validate newly added column DimCommercialBuildingSuitesSK for DimGJob and DimCBREDoor tables in dev Warehouse

  Scenario: Validate DimCommercialBuildingSuitesSK integration in DimGJob pipeline
    Given the column DimCommercialBuildingSuitesSK exists in the Config DB mapping for DimGJob
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for DimGJob
    And the DimCommercialBuildingSuitesSK column values should be NULL for DimGJob in warehouse
    When the PiDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PiCMDimensionMaster pipeline is triggered in Azure Synapse
    And the pipeline execution is completed successfully
    Then the column DimCommercialBuildingSuitesSK should have data loaded in the warehouse table DimGJob
    And the column values of DimCommercialBuildingSuitesSK in DimGJob should match with the values of column  DimCommercialBuildingSuitesSK in DimGJob
    And the number of records in DimGJob should match across datalake and warehouse
    And the data in DimGJob should match across datalake and warehouse	

  Scenario: Validate DimCommercialBuildingSuitesSK integration in DimCBREDoor pipeline
    Given the column DimCommercialBuildingSuitesSK exists in the Config DB mapping for DimCBREDoor
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for DimCBREDoor
    And the DimCommercialBuildingSuitesSK column values should be NULL for DimCBREDoor in warehouse
    When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PlCMDimensionMaster pipeline is triggered in Azure Synapse
    And the pipeline execution is completed successfully
    Then the column DimCommercialBuildingSuitesSK should have data loaded in the warehouse table DimCBREDoor
    And the column values of DimCommercialBuildingSuitesSK in DimCBREDoor should match with the values of column  DimCommercialBuildingSuitesSK in DimCBREDoor
    And the number of records in DimCBREDoor should match across datalake, and warehouse
    And the data in DimCBREDoor should match across datalake, and warehouse