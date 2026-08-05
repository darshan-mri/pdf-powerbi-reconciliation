Feature: Validate creation and structure of FactRetailBilling Fact table for Forbury	

  Scenario: Validate FactRetailBilling table structure
     Given the table FactRetailBilling exists in warehouse
     And the table FactRetailBilling contains the fields as per the mapping document
     And the column DimCommercialBuildingSuitesSK is defined as a surrogate key and set as primary key
     And the IsWHLoadEnabled and IsFullRefresh flags are set to 1 in the Config DB for FactRetailBilling
     When the PlDropAndRecreateCDMViews pipeline is triggered in Azure Synapse
     And the PlFactRetailBilling pipeline is triggered for all the customer in Azure Synapse
     And all pipeline executions complete successfully
     And the following fields are updated in the warehouse for FactRetailBilling table
       |DimCommercialBuildingSuitesSK|
       |DimCommercialLeasesSK|
       |DimIncomeCategoriesSK|
       |DimCommercialSalesTypesSK|
       |BillingFrequency|
       |Cumulative|
       |BillAtBreakpoint|
       |ReportTypeIdBilling|
       |BillMethod|
       |ReportTypeIdReconciliation|
       |AnnualReconciliation|
       |EstimateIncomeCategory|
       |CalculateEstimatedSales|
       |OffsetAmount|
       |ReconciliationFrequency|
       |FormulaId|
       |UserId|
       |LastDate|
       |BillingAddress|
       |FeeExempt|
       |PeriodNonCumulative|
     Then the CDM view for FactRetailBilling should be recreated successfully in datalake
     And the view in datalake should include all columns defined in the mapping document with the data loaded
     And the number of records in FactRetailBilling should match across datalake and warehouse
  	 And the data in FactRetailBilling should match across datalake and warehouse