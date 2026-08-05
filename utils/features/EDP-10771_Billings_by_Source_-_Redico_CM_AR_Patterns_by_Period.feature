Feature: Redico Commercial AR Patterns by Period

  Scenario: Verify Total Amount for Source Code 'Charge' in Billings by Source table  matches Total Billings keycard
    Given the user logs into PowerBI
    And selects the appropriate Workspace
    When the user opens the Redico Commercial AR Patterns by Period Report
    Then the visuals should display without any NAN/NUL/NILL/Blank values
    When the user navigates to the 'Billings by Source' table
    Then the Total Amount for Source 'Charge' should match the 'Total Billings' keycard
    And the user logs into the Warehouse
    And executes the following query:
    """
    SELECT SUM(H.transactionamount) AS Billings
    FROM MRI.FactCommercialARHistoryPeriod H
    INNER JOIN MRI.DimSourceCodes S ON S.DimSourceCodesSK = H.DimSourceCodesSK
    INNER JOIN MRI.DimCommercialBuildingSuites B ON B.DimCommercialBuildingSuitesSK = H.DimCommercialBuildingSuitesSK
    WHERE H.mriclientid = 'ClientID'
      AND H.Period = 'Reporting period (As of Date)'
      AND S.iscurrentrow = 1
      AND S.SourceCode = 'CH'
      AND S.SourceCode IS NOT NULL
      AND B.isActiveBuilding = 1
      AND SuiteArea > 0;
    """
    Then the result of the query should match the 'Total Billings' keycard