Feature: Financial Details + Interacting with Focus mode.

  Scenario Outline: User interacts with an option in the Financial Details report and views the respective table and applied filters
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    And User should be able to see the <Option>
    When User clicks on the <Option>
    Then User should be able to see the respective <Table>
    When User click on focus mode of the <Table>
    Then User should see the <Table> in full screen
    When User click on the Back button
    Then The table should be reverted back to the report

    Examples:
      | Table            | Option        |
      | YTD Comparison   | MOM Details   |
      | Variance Details | Variance      |