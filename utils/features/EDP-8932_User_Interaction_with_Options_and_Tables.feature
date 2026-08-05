Feature: B&F Financial Details
Scenario Outline: User interacts with options in the B&F Financial Details report and views tables
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    And User should be able to see the <Options>
    When User clicks on the <Options>
    Then User should be able to see the respective <Table> with the data.

    Examples:
      | Options     | Table                     |
      | MOM Details | Blended Forcast: Actuals  |
      | Variance    |                           |