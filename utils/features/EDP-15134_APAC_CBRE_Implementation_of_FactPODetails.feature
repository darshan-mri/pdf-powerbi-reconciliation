Feature: Validate creation and structure of FactPODetails Fact tables into warehouse

  Scenario: Validate FactPODetails table structure
    Given the table FactPODetails exists in warehouse
    And the table FactPODetails contains the fields as per the mapping document
    And the column DimEntitiesSK is defined as a surrogate key and set as primary key
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactPODetails
    When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PlFactPODetails pipeline is triggered in Azure Synapse
    And all pipeline executions complete successfully
    Then the CDM view for FactPODetails should be recreated successfully in datalake
    And the view in datalake should include all columns defined in the mapping document with the data loaded
    And the number of records in FactPODetails should match across datalake and warehouse
  	And the data in FactPODetails should match across datalake and warehouse