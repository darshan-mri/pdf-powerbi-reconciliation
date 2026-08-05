Feature: Commercial Rent Roll Report

  Scenario: Verify that Totals get displayed Based on Key Cards Selected
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the "Commercial Rent Roll" report
    Then the <Totals> for the following measures should be displayed at the bottom with proper decimal formats:
      | Totals              |
      | Total Sq.Ft         |
      | Monthly Rent        |
      | Annual Rent         |
      | Annual Rent PSF     |
      | Monthly Cost Recovery |
      | Monthly Other Income |
    When the user clicks any of the <key cards>
      | Key cards         |
      | Total Units       |
      | Occupied Units    |
      | Reserved Units    |
      | Vacant Units      |
    Then the values for the <Totals> should be updated