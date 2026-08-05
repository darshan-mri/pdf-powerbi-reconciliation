Feature: B&F Financial Details
Scenario: User selects and deselects a specific period in the YTD Variance % line graph
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    And User should be able to see the YTD Variance % line graph
    When User selects a specific period in the YTD Variance % line graph
    Then The data should be displayed in other visuals with respect to the selected period
    When User deselects the selected period
    Then The data should be reverted back to the previous state