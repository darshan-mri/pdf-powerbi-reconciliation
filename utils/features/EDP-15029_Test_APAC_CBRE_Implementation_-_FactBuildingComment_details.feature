Feature: Validate creation and structure of FactBuildingComment Fact tables into warehouse

  Scenario: Validate FactBuildingComment table structure
      Given the table FactBuildingComment exists in warehouse
      And the table FactBuildingComment contains the fields as per the mapping document
      And the column FactBuildingCommentSK is defined as a surrogate key and set as primary key
      And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactBuildingComment
      When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
      And the PlCMFactMaster pipeline is triggered in Azure Synapse
      And all pipeline executions complete successfully
      Then the CDM view for FactBuildingComment should be recreated successfully in datalake
      And the view in datalake should include all columns defined in the mapping document with the data loaded
      And the number of records in FactBuildingComment should match across datalake and warehouse
      And the data in FactBuildingComment should match across datalake and warehouse
      And the NULL value validation should match between the Warehouse and the Data Lake