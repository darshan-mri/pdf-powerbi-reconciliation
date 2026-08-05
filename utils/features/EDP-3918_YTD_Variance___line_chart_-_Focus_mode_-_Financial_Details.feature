Feature: Financial Details + Focus Mode for YTD Variance % Line Chart

  Scenario: User clicks on Focus mode for the YTD Variance % line chart
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    When User clicks on Focus mode for the YTD Variance % line chart
    Then the YTD Variance % line chart should be displayed in full screen with the lines and values intact
    And A back button should be available to navigate back to the home page