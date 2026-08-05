Feature: Financial Details Report

  Scenario: User validates the variance details data with the PMX report
      Given User is logged into PowerBI
      And User has selected the desired workspace
      When User opens the report
      Then User should see the variance option in the report
      When User clicks on the variance option
      Then User should be able to see the variance details table
      And The variance details table should display values that match the corresponding values shown in the provided PMX report