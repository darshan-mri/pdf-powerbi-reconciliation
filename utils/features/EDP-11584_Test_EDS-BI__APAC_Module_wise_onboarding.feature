Feature: Onboard Single Module and Load All Related Data

  Background:
    Given the module-related source tables contains all necessary data

  Scenario Outline: Onboard a single module and verify loaded data
    When the onboarding is triggered for "<ModuleName>" module
    Then the module should be successfully onboarded
    And all values from the module-related source table should be loaded into the warehouse
    And the data in the warehouse should match the source for the "<ModuleName>" module

  Examples:
    | ModuleName             |
    | Commercial Management  |
    | Financial Management   |
	  | Budget and Forecast 	 |