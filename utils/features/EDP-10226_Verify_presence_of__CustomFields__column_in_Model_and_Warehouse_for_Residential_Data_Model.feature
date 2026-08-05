Feature: Residential Data Model
  Scenario: Verify presence of 'CustomFields' column in Model and Warehouse for Residential Data Model
    Given User logs into Tabular Editor
    And User selects the appropriate Workspace and opens the required Data Model
    Then "CustomFields" column should be present in the following tables:
      | MRI Residential Tenants        |
      | MRI Residential Property Units |
      | MRI Residential Lease Details  |
      | MRI Residential Entities       |
    And User logs into the appropriate Warehouse
    And User executes the following query:
      """
      SELECT TOP 2 CustomFields, * FROM mri.DimPerson;
      SELECT TOP 2 CustomFields, * from mri.DimPropertyUnits;
      SELECT TOP 2 CustomFields, * from mri.DimResidentialLeases;
      SELECT TOP 2 CustomFields, * FROM mri.DimEntities;
      """
    Then "CustomFields" column should be present in the following Warehouse tables:
      | [MRI].[Dimperson]                   |
      | [MRI].[DimPropertyUnits]            |
      | [MRI].[DimResidentialLeases]        |
      | [MRI].[DimEntities]                 |