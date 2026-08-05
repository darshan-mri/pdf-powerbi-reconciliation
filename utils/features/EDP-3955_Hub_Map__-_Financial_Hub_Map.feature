Feature: Financial Hub Map + User Interactions

  Scenario: User interacts with the Financial Hub Map report
    Given User logs into PowerBI
    And User opens the Financial Hub Map report from the workspace
    Then User should see the states highlighted whose details are available in the Hub Map
    And User should be able to zoom in and zoom out in the Hub Map
    When User hovers over any of the highlighted states in the Hub Map
    Then User should see a tooltip with the following details:
      | State               |
      | State               |
      | Average of Latitude |
      | Average of Longitude|
      | Total Leasable Area |
      | Total Leased Area   |
      | Total Vacant Area % |
    And User should see the tooltip values matching with the values in the Hub Details table
    And user should not see any duplicate information in the tooltip
    When User selects any state on the Hub Map
    Then The keycards and Hub Details table values should be updated as per the state selected