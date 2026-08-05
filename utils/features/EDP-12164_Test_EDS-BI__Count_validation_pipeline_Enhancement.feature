Feature: Count Validation Pipeline Enhancement

  Scenario: Execute the pipeline and verify the count on Config DB
    Given the pipeline is configured and ready for execution
    When the pipeline is executed successfully
    And the user checks the counts from source to datalake
    Then the counts in the Config DB should match the expected values