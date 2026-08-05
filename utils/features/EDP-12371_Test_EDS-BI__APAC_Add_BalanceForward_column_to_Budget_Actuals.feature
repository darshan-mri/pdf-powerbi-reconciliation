Feature: Add Balance Forward column to FactFinancialGLBudgetActuals

  Scenario: Add Balance Forward column and load data

    Given the FactFinancialGLBudgetActuals table exists in the data warehouse
	  And BalanceForward column is added to FactFinancialGLBudgetActuals warehouse table
    When FactFinancialGLBudgetActuals pipeline is triggered in Azure synapse
    Then the BalanceForward column should contain correct balance forward amounts for each relevant record
    And existing data in other columns should remain unchanged
    And data should match with the source system