Feature: Validate PlRentPaymentLoadToTransform pipeline loads data to transform container

  Scenario Outline: Run RentPayment pipeline with IsFullRefresh = <IsFullRefresh> and validate parquet files are loaded
    When pipeline PlRentPaymentLoadToTransform is triggered with parameter IsFullRefresh = <IsFullRefresh>
    Then the pipeline should complete successfully
    And the parquet files should be loaded in the container folder "transform/rentpayment/<runDateFolder>"
    And the parquet files should be valid for IsFullRefresh = <IsFullRefresh>

    Examples:
      | IsFullRefresh |
      | 1             |
      | 0             |