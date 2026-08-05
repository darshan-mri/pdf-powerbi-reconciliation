Feature: RLS load in Master Onboard pipeline

  Background:
    Given the Master onboarding pipeline is configured in the environment

  Scenario: Validate that PlRLSDataLoad and PlEntitySecurityForUser are integrated and load RLS data successfully
    When the Master onboarding pipeline is triggered for a new customer
    Then the PlRLSDataLoad pipeline should be executed as part of the Master onboarding pipeline
    And the PlEntitySecurityForUser pipeline should be executed as part of the Master onboarding pipeline
    And the RLS users data should be loaded successfully into the warehouse tables