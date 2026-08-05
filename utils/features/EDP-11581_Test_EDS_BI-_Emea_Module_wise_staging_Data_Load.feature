Feature: Module-wise Data Load Support in Dataload Pipeline

  Background:
    Given the masterdataload pipeline is available
    And the stagingload, transformload, and warehouseload pipelines exist

  Scenario Outline: Trigger module-wise data load
    When the dataload pipeline is treiggered with the Application parameter "<ModuleName>"
    Then the stagingload pipeline should be triggered for the "<ModuleName>" module
    And the transformload pipeline should be triggered for the "<ModuleName>" module
    And the warehouseload pipeline should be triggered for the "<ModuleName>" module
    And only data for the "<ModuleName>" module should be processed without any issues

    Examples:
      | ModuleName              |
      | Residential Management  |
      | Commercial Management   |
      | Financial Management    |