Feature: Validate creation and structure of FactCommercialInsurenceDetails fact table	

  Scenario: Validate FactCommercialInsurenceDetails table structure
     Given the table FactCommercialInsurenceDetails exists in warehouse
     And the table FactCommercialInsurenceDetails contains the fields as per the mapping document
     And the column FactCommercialInsurenceDetailsSK is defined as a surrogate key and set as primary key
     And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactCommercialInsurenceDetails
     When the PIDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
     And the FactCommercialInsurenceDetails pipeline is triggered in Azure Synapse
     And all pipeline executions complete successfully
     Then the CDM view for FactCommercialInsurenceDetails should be recreated successfully in datalake
     And the view in datalake should include all columns defined in the mapping document with the data loaded
     And the number of records in FactCommercialInsurenceDetails should match across datalake and warehouse
     And the data in FactCommercialInsurenceDetails should match across datalake and warehouse
     And the NULL value validation should match between the Warehouse and the Data Lake