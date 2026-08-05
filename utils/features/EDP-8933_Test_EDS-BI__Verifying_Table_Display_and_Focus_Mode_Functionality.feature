Feature: B&F Financial Details
Scenario Outline: User interacts with options in the B&F Financial Details report and views tables in focus mode
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    Then User should be able to see the <Options>
    When User clicks on the <Options>
    Then User should be able to see the respective <Table>
    When User clicks on Focus mode for the <Table>
    Then The <Table> should be displayed in full screen with the lines and values intact
    And The user should see a back button to navigate back to the home page

    Examples:
      | Options     | Table                       |
      | MOM Details | Blended Forcast: Actuals    |
      | Variance    |                             |