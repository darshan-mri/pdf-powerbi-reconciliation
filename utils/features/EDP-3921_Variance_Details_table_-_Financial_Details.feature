Feature: Financial Details + Variance Details Table Interaction

  Scenario: User interacts with the Variance Details table and views updated visuals
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    When User clicks on the Variance button
    Then The Variance Details table should be displayed
    When User clicks on any of the columns in the Variance Details table
    Then The values in the Variance Details table should be sorted accordingly
    When User clicks on any of the Account Filter Name values
    Then User should see the selected row is highlighted and the opacity of unselected rows should be reduced
    And User should see the changes reflected in the YTD Variance % line chart and the Blended Forecast Details table as per the selected row
    When User selects any single value from any of the columns except Account Filter Name
    Then User should see the selected value is highlighted
    And User should see the changes reflected in the YTD Variance % line chart and the Blended Forecast Details table as per the selected value