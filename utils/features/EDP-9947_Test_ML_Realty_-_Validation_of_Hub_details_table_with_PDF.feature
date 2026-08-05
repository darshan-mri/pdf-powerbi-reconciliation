Feature: MLRealty Hub Details Map
Scenario: User validates the Hub Details data with the PMX report
    Given User is logged into PowerBI
    And User has selected the desired workspace
    When User opens the MLRealty Hub Details Map report
    Then User should see the Hub Details table in the report
    And The <Totals> row in Hub details table should display values that match the corresponding values shown in the provided PMX report
    | Entity Total Area |
    | Entity Leased Area  |
    | Leased Area%  |