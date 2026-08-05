Feature: B&F Financial Details
Scenario Outline: User interacts with options, sorts, and filters in the Financial Details report and sees reflected changes
    Given User logs into PowerBI
    And User opens the Financial Details report from the workspace
    And User should be able to see the <Option>
    When User clicks on the <Option>
    Then User should be able to see the respective <Table> with the data
    When User clicks on the Account filter name column of the <Table>
    Then The values in the <Table> should be sorted
    When User clicks any of the month columns in the <Table>
    Then That column should be highlighted
    And User should see the changes reflected in the YTD Variance % line chart and Blended Forecast Details:Actuals table as per the selected column
    When User clicks on the value in the Account filter name column
    Then The selected row should be highlighted and opacity of unselected rows should be reduced
    And User should see the changes reflected in the YTD Variance % line chart and Blended Forecast Details:Actuals table as per the selected row
    When User selects any single value under any of the month columns
    Then The selected value should be highlighted
    And User should see the changes reflected in the YTD Variance % line chart and Blended Forecast Details:Actuals table as per the selected value
    When User deselects the selected column or row
    Then The report should be reverted back as previous

    Examples:
      | Option           | Table                        |
      | MOM Details      | Blended Forecast: Actuals    |
      | Variance         |                              |