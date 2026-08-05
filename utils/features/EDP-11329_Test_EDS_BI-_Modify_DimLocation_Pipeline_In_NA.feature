Feature: DimLocation pipeline loading from DimEntities when city/state is not present

  Scenario: Populate DimLocation from DimEntities when city/state is not present
    Given that few city and state values are not present in DimLocation
    When I trigger the DimLocation pipeline for a customer
    Then the pipeline should complete successfully
    And the missing city/state values should now be loaded in DimLocation from DimEntities

  Scenario: Do not duplicate city/state if already present in DimLocation
    Given that some city and state already exists in DimLocation
    When I trigger the DimLocation pipeline for a customer
    Then the pipeline should complete successfully
    And the DimLocation table should not contain duplicate entries for existing city and state