Feature: Validate creation and structure of FactUrbisRent and FactTenantUrbis Fact table	

  Scenario: Validate FactUrbisRent table structure
    Given the table FactUrbisRent exists in warehouse
    And the table FactUrbisRent contains the fields as per the mapping document
    And the column DimCommercialLeasesSK is defined as a surrogate key and set as primary key
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactUrbisRent
    When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PlCMFactMaster pipeline is triggered in Azure Synapse
    And all pipeline executions complete successfully
    Then the CDM view for FactUrbisRent should be recreated successfully in datalake
    And the view in datalake should include all columns defined in the mapping document with the data loaded
    And the number of records in FactUrbisRent should match across datalake and warehouse
    And the data in FactUrbisRent should match across datalake and warehouse
    And the NULL value validation should match between the Warehouse and the Data Lake
	
  Scenario: Validate FactTenantUrbis table structure
    Given the table FactTenantUrbis exists in warehouse
    And the table FactTenantUrbis contains the fields as per the mapping document
    And the column DimCommercialLeasesSK is defined as a surrogate key and set as primary key
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactTenantUrbis
    When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PlCMFactMaster pipeline is triggered in Azure Synapse
    And all pipeline executions complete successfully
    Then the CDM view for FactTenantUrbis should be recreated successfully in datalake
    And the view in datalake should include all columns defined in the mapping document with the data loaded
    And the number of records in FactTenantUrbis should match across datalake and warehouse
    And the data in FactTenantUrbis should match across datalake and warehouse
    And the NULL value validation should match between the Warehouse and the Data Lake