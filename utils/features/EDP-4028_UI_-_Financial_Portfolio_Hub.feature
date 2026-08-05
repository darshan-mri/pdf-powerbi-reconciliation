Feature: Visual and Value Alignment in the Financial Portfolio Hub Report

  Scenario: User verifies the alignment and consistency of visuals and tables in the Financial Portfolio Hub report
    Given User logs into PowerBI
    And User opens Financial Portfolio Hub report from the workspace
    Then User should see all the visuals and values aligned properly with no misalignments
    And User should see the Titles should match the visuals displayed
    And User should see the Column Name and Column Values in the tables aligned in the same line as below:
      | If column name is left aligned then column values also should be left aligned |
      | If column name is right aligned then column values also should be right aligned |
    And User should see the Columns with Numbers are Right aligned and Columns with other values are left aligned in tables
    And User should see the standard font style and size in the report