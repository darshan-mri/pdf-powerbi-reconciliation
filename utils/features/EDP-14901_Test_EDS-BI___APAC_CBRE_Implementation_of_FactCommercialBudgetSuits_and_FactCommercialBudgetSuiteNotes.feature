Feature: Validate creation and structure of FactCommercialBudgetSuites and FactCommercialBudgetSuiteNotes Fact table	

  Scenario: Validate FactCommercialBudgetSuites table structure
    Given the table FactCommercialBudgetSuites exists in warehouse
    And the table FactCommercialBudgetSuites contains the fields as per the mapping document
    And the column FactCommercialBudgetSuitesSK is defined as a surrogate key and set as primary key
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactCommercialBudgetSuites
    When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PlCMFactMaster pipeline is triggered in Azure Synapse
    And all pipeline executions complete successfully
    Then the CDM view for FactCommercialBudgetSuites should be recreated successfully in datalake
    And the view in datalake should include all columns defined in the mapping document with the data loaded
    And the number of records in FactCommercialBudgetSuites should match across datalake and warehouse
    And the data in FactCommercialBudgetSuites should match across datalake and warehouse 
	
  Scenario: Validate FactCommercialBudgetSuiteNotes table structure
    Given the table FactCommercialBudgetSuiteNotes exists in warehouse
    And the table FactCommercialBudgetSuiteNotes contains the fields as per the mapping document
    And the column FactCommercialBudgetSuitesSK is defined as a surrogate key and set as primary key
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactCommercialBudgetSuiteNotes
    When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PlCMFactMaster pipeline is triggered in Azure Synapse
    And all pipeline executions complete successfully
    Then the CDM view for FactCommercialBudgetSuiteNotes should be recreated successfully in datalake
    And the view in datalake should include all columns defined in the mapping document with the data loaded
    And the number of records in FactCommercialBudgetSuiteNotes should match across datalake and warehouse
    And the data in FactCommercialBudgetSuiteNotes should match across datalake and warehouse