Feature: Days Vacant Details table

Scenario: Verify table data and key card values for Days Vacant
  Given User logs into Power BI
  And User selects the workspace
  When User opens the Residential Vacancy report
  And clicks on Days Vacant Details
  Then the table headers along with proper data should be loaded
  And the total values in the table should match the key card values
  Then user logs into warehouse
  And Exceutes the Following Query:
    """with CTE as (
      select 
          count(*) as TotalDays,
          sum(case when D.UnitStatus = 'A' then 1 else 0 end) as TotalVacantDays,
          sum(case when D.UnitStatus = 'A' then DailyRate else 0 end) as VacancyLoss
      from MRI.FactDailyUnitHistory D
      inner join MRI.DimPropertyUnits U on U.DimPropertyUnitsSK = D.DimPropertyUnitsSK
      where D.EffectiveDate >= '' and D.EffectiveDate <= ''
      and U.isCurrentRow = 1 and U.MRIClientID = 'ClientID' and U.UnitID = 'UnitId' and U.UnitID != '-'
    )
    select 
        TotalDays,
        TotalVacantDays,
        CAST(ROUND((TotalVacantDays) * 100.0 / TotalDays, 2) as float) as VacancyRate,
        VacancyLoss
    from CTE;"""
  Then Totals in Days Vacant details table PowerBi report should match warehouse values 
  When User selects any of the records from the table
  Then the data related to the selected record should be displayed in key cards and other visuals