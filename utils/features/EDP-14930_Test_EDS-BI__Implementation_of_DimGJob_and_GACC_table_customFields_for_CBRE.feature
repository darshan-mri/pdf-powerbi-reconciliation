Feature: Validate creation and structure of DimGJob Dimention table	and insert Custom Fields into the DimchartOfAccounts table

  Scenario: Validate DimGJob table structure
    Given the table DimGJob exists in warehouse
    And the table DimGJob contains the fields as per the mapping document
    And the column DimCBREManagementReportSK is defined as a surrogate key and set as primary key
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for DimGJob
    When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PlCMDimensionMaster pipeline is triggered in Azure Synapse
    And all pipeline executions complete successfully
    Then the CDM view for DimGJob should be recreated successfully in datalake
    And the view in datalake should include all columns defined in the mapping document with the data loaded
    And the number of records in DimGJob should match across datalake and warehouse
  	And the data in DimGJob should match across datalake and warehouse 
	
  Scenario: Validate Custom Fields integration in DimchartOfAccounts pipeline
    Given the column DimchartOfAccounts  exists in the Config DB mapping for DimchartOfAccounts
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for DimchartOfAccounts
    And the Custom Fields column values should be NULL for DimchartOfAccounts in warehouse
    When the PiDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PiCMDimensionMaster pipeline is triggered in Azure Synapse
    And the pipeline execution is completed successfully
    Then the column Custom Fields should have data loaded in the warehouse table DimchartOfAccounts
    And the number of records in DimchartOfAccounts should match across datalake and warehouse
    And the data in DimchartOfAccounts should match across datalake and warehouse