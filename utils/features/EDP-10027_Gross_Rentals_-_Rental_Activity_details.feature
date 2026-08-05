Feature: Verify Residential Rental Activity Report

  Background:
    Given User Logs into PowerBI
    And User Selects appropriate Workspace

  Scenario: Validate Gross Rentals Totals
    When User Opens Residential Rental Activity report
    Then Visuals in the report should appear
    And User clicks on More Details from 7 Day Activity key card
    Then the table headers along with proper data should be loaded for Rental Activity Details table

    When User Logs into Database
    And User Executes the following Query
      | query |
      | select count(*) as GrossRentalsTotals from MRI.FactActions m inner join [MRI].[DimPropertyUnits] b on m.DimPropertyUnitsSK=b.DimPropertyUnitsSK where m.NewApplicant<='asofdate' and m.NewApplicant>='asofdate-7' and m.isCurrentrow=1 and b.isActiveProperty=1 and m.mriclientid='ClientID' |
    Then The Totals for Gross Rentals column should match with value from Database
    And Ensure Gross Rentals Column uses 'Gross Rentals Last 7 days' Measure