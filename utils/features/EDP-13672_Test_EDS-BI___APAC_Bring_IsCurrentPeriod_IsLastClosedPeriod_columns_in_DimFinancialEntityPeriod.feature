Feature: Add IsCurrentPeriod and IsLastClosedPeriod columns to DimFinancialEntityPeriod

  Scenario: Add IsCurrentPeriod, IsLastClosedPeriod columns and load data

    Given the DimFinancialEntityPeriod table exists in the data warehouse
	  And IsCurrentPeriod and IsLastClosedPeriod columns is added to DimFinancialEntityPeriod warehouse table
    When DimFinancialEntityPeriod pipeline is triggered in Azure synapse
    Then the IsCurrentPeriod and IsLastClosedPeriod columns should contain correct balance forward amounts for each relevant record
    And existing data in other columns should remain unchanged
	  And IsLastClosedPeriod column should be 1 for current or last period for each entity
	  And warehouse data should match with the Datalake