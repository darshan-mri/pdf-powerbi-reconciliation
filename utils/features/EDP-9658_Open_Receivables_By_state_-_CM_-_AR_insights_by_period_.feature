Feature: Cpmmercial AR Insights by Period - Open Receivables by State Chart
Scenario: User interacts with the Open Receivables By State chart
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The user should be able to see the "Open Receivables By State" chart by scrolling down
    And The states should be highlighted on the chart
    When User scrolls up on the visual
    Then The visual should zoom in
    When User scrolls down on the visual
    Then The visual should zoom out
    When User selects any state
    Then All visuals should be updated according to the selected state
    When User deselects the selected state
    Then All visuals should revert back to the default state