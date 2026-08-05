Feature: Financial Details + Blended Forecast Table Interaction and Filter Visibility  
  
  Scenario: User interacts with the Blended Forecast table and views updated visuals
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    Then User should see the legends for Actual and Budget in the Blended Forecast table
    And User should see Actual values in blue and Budget values in green
    And User should see the table with MoM values for the complete year of the selected period
    When User clicks on any of the Account Filter Name values
    Then User should see the selected row is highlighted and the opacity of unselected rows is reduced
    And User should see the changes reflected in the YTD Variance % line chart and the Blended Forecast Details table as per the selected row
    When User clicks on any value in the Blended Forecast table under the months column
    Then User should see the selected value is highlighted
    And User should see the changes reflected in the YTD Variance % line chart and the Blended Forecast Details table as per the selected value
    When User clicks on the Account Filter Name column
    Then User should see the values in the Blended Forecast table sorted accordingly
    When User clicks on any month column in the Blended Forecast table
    Then User should see the changes reflected in the YTD Variance % line chart and the Blended Forecast Details table as per the selected column