Feature: Validate creation and structure of FactFinancialGJobBudget and FactJobCodeCBREBudgets Fact table	

  Scenario: Validate FactFinancialGJobBudget table structure
    Given the table FactFinancialGJobBudget exists in warehouse
    And the table FactFinancialGJobBudget contains the fields as per the mapping document
    And the column DimGJobSK is defined as a surrogate key and set as primary key
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactFinancialGJobBudget
    When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PlFMFactMaster pipeline is triggered in Azure Synapse
    And all pipeline executions complete successfully
    Then the CDM view for FactFinancialGJobBudget should be recreated successfully in datalake
    And the view in datalake should include all columns defined in the mapping document with the data loaded
    And the number of records in FactFinancialGJobBudget should match across datalake and warehouse
    And the data in FactFinancialGJobBudget should match across datalake and warehouse 
	
  Scenario: Validate FactJobCodeCBREBudgets table structure
    Given the table FactJobCodeCBREBudgets exists in warehouse
    And the table FactJobCodeCBREBudgets contains the fields as per the mapping document
    And the column DimGJob is defined as a surrogate key and set as primary key
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactJobCodeCBREBudgets
    When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PlFMFactMaster pipeline is triggered in Azure Synapse
    And all pipeline executions complete successfully
    Then the CDM view for FactJobCodeCBREBudgets should be recreated successfully in datalake
    And the view in datalake should include all columns defined in the mapping document with the data loaded
    And the number of records in FactJobCodeCBREBudgets should match across datalake and warehouse
    And the data in FactJobCodeCBREBudgets should match across datalake and warehouse