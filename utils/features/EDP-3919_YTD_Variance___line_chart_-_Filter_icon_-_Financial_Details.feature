Feature: Financial Details + Hover Over Filter Icon

  Scenario: User hovers over the filter icon of YTD Variance % line chart
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    When User hovers over the filter icon of YTD Variance % line chart
    Then User should see the applied filters