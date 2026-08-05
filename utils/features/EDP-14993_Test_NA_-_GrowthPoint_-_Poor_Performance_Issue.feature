Feature: Validate CMLEDG data propagation from Source to Data Lake
  
  Scenario: Insert new records for CMLEDG in source and validate data propagation to Data Lake
	   Given New records with valid data are inserted into the CMLEDG table in the source system
     And the IsWHLoadEnabled and IsFullRefresh flag is set to 1 in the Config DB for CMLEDG
     When the PlMasterDataloadforCustomer pipeline is triggered in Azure Synapse
     And the pipeline execution completes successfully
     Then the view "{CustomerName}.vwCMLEDG" should contain the newly inserted source records
     And the CMLEDG table in the Data Lake should contain the newly inserted records
     And the data between Source and Data Lake for CMLEDG should match