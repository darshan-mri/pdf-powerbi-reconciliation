Feature: Financial Data Model
  Scenario: Verify presence of 'CustomFields' column in Model and Warehouse for Financial Data Model
    Given User logs into Tabular Editor
    And User selects the appropriate Workspace and opens the required Data Model
    Then "CustomFields" column should be present in the following tables:
      | MRI Commercial Building Suites  |
      | MRI Financial Entities          |
    And User logs into the appropriate Warehouse
    And User executes the following query:
      """
      SELECT TOP 2 CustomFields, * FROM mri.DimCommercialBuildingSuites;
      SELECT TOP 2 CustomFields, * FROM mri.DimEntities;
      """
    Then "CustomFields" column should be present in the following Warehouse tables:
      | [MRI].[DimCommercialBuildingSuites] |
      | [MRI].[DimEntities]                 |