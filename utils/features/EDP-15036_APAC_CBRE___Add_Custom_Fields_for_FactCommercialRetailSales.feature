Feature: Validate newly added Custom Fields column integration for FactCommercialRetailSales Warehouse tables

  Scenario: Validate Custom Fields data load into Warehouse tables after pipeline execution
    Given the Custom Fields column exists in the Config DB mapping for the FactCommercialRetailSales tables
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactCommercialRetailSales table
    And the Custom Fields column contains NULL values in all corresponding Warehouse tables before pipeline execution
    When the PiDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PlRetailMgmFactMaster pipelines is triggered in Azure Synapse
    And the pipeline execution is completed successfully
    Then the Custom Fields column should be created and populated with data in Warehouse tables for below fields
	       |ReportedDate |
	       |LastUpdate   |
	       |UserID       |
    And the custom fields should not show the Null values in the warehouse
    And the record count should match between Data Lake and Warehouse for all tables
    And the data values in the Custom Fields column should match between Data Lake and Warehouse