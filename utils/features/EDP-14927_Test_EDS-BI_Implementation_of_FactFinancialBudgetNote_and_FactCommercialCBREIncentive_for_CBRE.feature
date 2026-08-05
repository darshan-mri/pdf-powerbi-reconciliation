Feature: Validate creation and structure of FactCommercialCBREIncentive and FactFinancialBudgetNotes Fact tables into warehouse

  Scenario: Validate FactCommercialCBREIncentive table structure
    Given the table FactCommercialCBREIncentive exists in warehouse
    And the table FactCommercialCBREIncentive contains the fields as per the mapping document
    And the column DimCommercialLeasesSK is defined as a surrogate key and set as primary key
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactCommercialCBREIncentive
    When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PlCMFactMaster pipeline is triggered in Azure Synapse
    And all pipeline executions complete successfully
    Then the CDM view for FactCommercialCBREIncentive should be recreated successfully in datalake
    And the view in datalake should include all columns defined in the mapping document with the data loaded
    And the number of records in FactCommercialCBREIncentive should match across datalake and warehouse
  	And the data in FactCommercialCBREIncentive should match across datalake and warehouse 
	
  Scenario: Validate FactFinancialBudgetNotes table structure
    Given the table FactFinancialBudgetNotes exists in warehouse
    And the table FactFinancialBudgetNotes contains the fields as per the mapping document
    And the column DimChartOfAccountsSK is defined as a surrogate key and set as primary key
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactFinancialBudgetNotes
    When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PlFMFactMaster pipeline is triggered in Azure Synapse
    And all pipeline executions complete successfully
    Then the CDM view for FactFinancialBudgetNotes should be recreated successfully in datalake
    And the view in datalake should include all columns defined in the mapping document with the data loaded
    And the number of records in FactFinancialBudgetNotes should match across datalake and warehouse
  	And the data in FactFinancialBudgetNotes should match across datalake and warehouse