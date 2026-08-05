Feature: RLSDataload and EntitySecurityForUser pipelines

  Scenario: Validate RLSDataload pipeline for a customer

    Given the customer has a ClientId present in the source database
    When the RLSDataload pipeline is triggered for a customer
    Then the pipeline should complete successfully
    And the RLS data should be loaded into the RLSUsers table of Security schema in the warehouse for the customer
	  And there should be no duplicate records
	  And the data should match the source data
	
  Scenario: EntitySecurityForUser pipeline runs SecurityTables when all required source tables exist

    Given the customer has a ClientId present in the source database
    And all required tables exist in the source for the customer
      | TableName    |
      | MRICLDEFENT  |
      | SITEMAP      |
      | MRICLDEF     |
      | SITE         |
      | SITEUSERS    |
      | Entity       |
      | MRIUSER      |
    When the EntitySecurityForUser pipeline is triggered
    Then the pipeline should complete successfully
    And the SecurityTables step should be executed
    And the data should be loaded in EntitySecurityMapping table of Security schema in the warehouse
    And there should be no duplicate records
    And the data in the warehouse should match the data in the source


  Scenario: EntitySecurityForUser pipeline skips SecurityTables when source tables are missing

    Given the customer has a ClientId present in the source database
    And one or more required tables are missing in the source for the customer
    When the EntitySecurityForUser pipeline is triggered
    Then the pipeline should complete successfully
    And the SecurityTables step should be skipped
    And no data should be loaded into the Security schema for the customer