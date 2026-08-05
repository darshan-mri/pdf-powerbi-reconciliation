Feature: Validate creation and structure of DimFinancialJournalStatus dimension table

  Scenario: Validate DimFinancialJournalStatus table structure and integration
    Given the table DimFinancialJournalStatus exists in the warehouse
    And the table DimFinancialJournalStatus contains the fields as per the mapping document
    And the column DimFinancialJournalStatusSK is defined as a surrogate key and set as primary key
    And the table FactFinancialJournals has a foreign key reference to DimFinancialJournalStatusSK in DimFinancialJournalStatus
	  And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for DimFinancialJournalStatus and FactFinancialJournals
    When the PIDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
	  And the DimFinancialJournalStatus pipeline is triggered in Azure Synapse
	  And the FactFinancialJournals pipeline is triggered in Azure Synapse
    And all pipeline executions complete successfully
    Then the CDM view for DimFinancialJournalStatus should be recreated successfully in datalake
    And the view in datalake should include all columns defined in the mapping document with the data loaded
  	And the DimFinancialJournalStatusSK should have values loaded based on the mapping in FactFinancialJournals
    And the number of records in DimFinancialJournalStatus and FactFinancialJournals should match across source, datalake, and warehouse
  	And the data in DimFinancialJournalStatus and FactFinancialJournals should match across source, datalake, and warehouse