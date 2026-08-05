Feature: Create and Load Customer-Specific Financial Format Data from Master Pipeline

  Background:
    Given the PlMasterCreatePipelines pipeline is available
    And the PlGetFormat, FinancialFormat, and DimChartOfAccounts pipelines exist
    And the source system contains valid financial format data for the customer

  Scenario: Create and execute customer-specific Master financial format pipeline
    When the PlMasterCreatePipelines pipeline is triggered
    Then the customer-specific Master financial format pipeline should be created
    When the customer-specific Master financial format pipeline is triggered
    Then the PlGetFormat pipeline should be triggered for that customer
    And the FinancialFormat pipeline should be triggered for that customer
    And the DimChartOfAccounts pipeline should be triggered for that customer
    And the financial format data should be loaded for the customer into DimFinancialFormat
    And the chart of accounts data should be loaded for the customer into DimChartOfAccounts
    And the financial format data in the warehouse should match the source data for the customer