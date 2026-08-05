Feature: Exchange Rate Filter - Financial NOI Analysis

  Scenario Outline: User applies <Exchange Rate> filter to update the report
    Given User logs into PowerBI
    And User opens Financial NOI Analysis report from the workspace
    When User selects <Exchange Rate> filter from the filters pane
    Then The report should be updated as per the selected <Exchange Rate> filter
    And The values in the report should be updated as per the <Exchange Rate> filter selected

  Examples:
    | Exchange Rate     |
    | American Dollar   |
    | Mexican Peso      |