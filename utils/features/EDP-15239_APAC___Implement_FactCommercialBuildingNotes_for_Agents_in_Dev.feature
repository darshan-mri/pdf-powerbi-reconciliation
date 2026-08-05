Feature: Validate creation and structure of FactCommercialBuildingNotes Fact table for JLL, KnightFrank, CBUSCBRE	

  Scenario: Validate FactCommercialBuildingNotes table structure
    Given the table FactCommercialBuildingNotes exists in warehouse
    And the table FactCommercialBuildingNotes contains the fields as per the mapping document
    And the column DimCommercialBuildingSuitesSK is defined as a surrogate key and set as primary key
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactCommercialBuildingNotes
    When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PlFactCommercialBuildingNotes pipeline is triggered for all the customer in Azure Synapse
    And all pipeline executions complete successfully
    And the following fields are loaded in the warehouse for FactCommercialBuildingNotes table
      |DimReferenceTypesSK1|
      |DimReferenceTypesSK2|
      |DimCommercialBuildingSuitesSK|
      |NoteDate|
      |Note|
      |NumberOfMonths|
      |LastDate|
    Then the CDM view for FactCommercialBuildingNotes should be recreated successfully in datalake
    And the view in datalake should include all columns defined in the mapping document with the data loaded
    And the Record counts for FactCommercialBuildingNotes match between Warehouse and Data Lake
    And the data values for FactCommercialBuildingNotes match between Warehouse and Data Lake