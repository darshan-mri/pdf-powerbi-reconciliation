Feature: Automate Data Refresh and Optimize Fact Table Loads with Separate IRs

  Background:
    Given the customer dataload pipeline exists
    And separate IRs for small, medium, and large Fact tables are configured and available
	  And DataRefresh csv file exists in the container

  Scenario: Automate data refresh using CSV file and run dataload pipeline with IR splitting
    When the data refresh is triggered with client information and required fields in the container
    Then the customer dataload pipeline should be triggered automatically for the client and module details added in the CSV file
    And the tables with less than 1000 rows should use the small capacity IR
    And the tables with medium-sized data should use the medium capacity IR
    And the tables with large data (e.g., Journals, Ledgers) should use the high capacity IR
    And when the dataload pipelines run in parallel using separate IRs, no pipeline execution should fail due to resource constraints