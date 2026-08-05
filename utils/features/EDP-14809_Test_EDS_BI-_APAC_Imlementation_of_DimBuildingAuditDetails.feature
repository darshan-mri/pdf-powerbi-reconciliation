Feature: Validate creation and data accuracy of DimBuildingAuditDetails dimension table

  Scenario: Validate successful execution and data consistency of DimBuildingAuditDetails Pipeline
    Given the "DimBuildingAuditDetails" pipeline exists in Azure Synapse
    When the "DimBuildingAuditDetails" pipeline is triggered in Azure Synapse
    Then the pipeline run should complete successfully
    And the record count in the DimBuildingAuditDetails table should match between Data Lake and Warehouse
    But if the counts do not match
    Then the sum of error records and actual loaded records should equal the expected Data Lake count