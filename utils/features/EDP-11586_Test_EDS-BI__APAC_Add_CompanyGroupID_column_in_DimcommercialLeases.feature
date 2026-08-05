Feature: Add CompanyGroupID Column to DimCommercialLeases Table

  Background:
    Given the DimCommercialLeases table and CompanyGroupID column exists in the data warehouse
    And the CDM logic is updated in config database to include CompanyGroupID in DimCommercialLeases

  Scenario: Data load for CompanyGroupID column in DimCommercialLeases
    When the DimCommercialLeases pipeline is triggered
    Then the data pipeline runs successfully
    And the CompanyGroupID values should be correctly populated in warehouse
	  And the DimCommercialLeases values in warehouse should match with the source
	  And the existing field data should not be affected