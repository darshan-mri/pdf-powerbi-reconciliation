Feature: Financial Details + Interacting with Options and Viewing Filters

  Scenario Outline: User interacts with an option in the Financial Details report and views the respective table and applied filters
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    And User should be able to see the <Option>
    When User clicks on the <Option>
    Then User should be able to see the respective <Table>
    When User hovers over the filter icon of the <Table>
    Then User should see the applied filters

    Examples:
      | Table            | Option        |
      | YTD Comparison   | MOM Details   |
      | Variance Details | Variance      |