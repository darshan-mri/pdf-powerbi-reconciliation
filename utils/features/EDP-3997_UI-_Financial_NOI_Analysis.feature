Feature: Financial NOI Analysis - User verifies the alignment and consistency of visuals and values

  Scenario: Financial NOI Analysis - User verifies the alignment and consistency of visuals and values
    Given User logs into PowerBI
    And User opens Financial NOI Analysis report from the workspace
    Then User should see all the visuals and values aligned properly with no misalignments
    And User should see the Titles match the visuals displayed
    And User should see the Column Name and Column Values in the tables aligned in the same line as below:
      | If column name is left aligned then column values also should be left aligned |
      | If column name is right aligned then column values also should be right aligned |
    And User should see the Columns with Numbers are right aligned and Columns with other values are left aligned in tables
    And User should see the standard font style and size in the report