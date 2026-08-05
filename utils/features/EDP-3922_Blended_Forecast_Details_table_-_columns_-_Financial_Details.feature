Feature: Financial Details + Blended Forecast Table Interaction and Updated Visuals

  Scenario: User interacts with the Blended Forecast table and views updated visuals
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    Then User should be able to see the Blended Forecast table
    And The values in each row and column should be properly aligned
    When User clicks on the Entity column of the Blended Forecast Details table
    Then The values in the Blended Forecast Details table should be sorted
    When User clicks on any of the month columns in the Blended Forecast Details table
    Then That column should be highlighted
    And User should see the changes reflected in the YTD Variance % line chart and the Blended Forecast table as per the selected column
    When User clicks on the value in the Entity column
    Then The selected row should be highlighted and the opacity of unselected rows should be reduced
    And User should see the changes reflected in the YTD Variance % line chart and the Blended Forecast table as per the selected row
    When User selects any single value under any of the month columns
    Then The selected value should be highlighted
    And User should see the changes reflected in the YTD Variance % line chart and the Blended Forecast table as per the selected value
    When User clicks on the plus icon of any value in the Entity column of the Blended Forecast Details table
    Then The Account column and values should be displayed in the Blended Forecast Details table
    When User clicks on the plus icon of any value in the Account column of the Blended Forecast Details table
    Then The Account Number column and values should be displayed in the Blended Forecast Details table
    When User clicks on any value in the Account or Account Number column
    Then The selected row should be highlighted and the opacity of unselected rows should be reduced
    And User should see the changes reflected in the YTD Variance % line chart and the Blended Forecast table as per the selected row