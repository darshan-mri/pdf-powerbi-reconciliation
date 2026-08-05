Feature: Validate creation and structure of DimAlternateChartOfAccounts Dimention table
  Scenario: Validate DimAlternateChartOfAccounts table structure
    Given the table DimAlternateChartOfAccounts exists in warehouse
    And the table DimAlternateChartOfAccounts contains the fields as per the mapping document
    And the column DimAlternateChartOfAccountsSK is defined as a surrogate key and set as primary key
    And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for DimAlternateChartOfAccounts
    When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
    And the PlCMDimensionMaster pipeline is triggered in Azure Synapse
    And all pipeline executions complete successfully
    Then the CDM view for DimAlternateChartOfAccounts should be recreated successfully in datalake
    And the view in datalake should include all columns defined in the mapping document with the data loaded
    And the number of records in DimAlternateChartOfAccounts should match across datalake and warehouse
  	And the data in DimAlternateChartOfAccounts should match across datalake and warehouse