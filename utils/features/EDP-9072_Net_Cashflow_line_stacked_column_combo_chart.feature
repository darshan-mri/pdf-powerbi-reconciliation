Feature: B&F Financial Portfolio Hub

  Scenario: Verify Net Cashflow keycard and related visuals interactions
    Given the user logs into Power BI
    When the user opens the Financial Portfolio Hub report from the workspace
    And the user clicks on the Net Cashflow keycard
    Then the user sees the Net Cashflow line stacked column combo chart with the following legends:
      | Net Cashflow |
      | Budget       |
    Then the user should be able to see the bars in the chart as per the amount range
    When the user hovers over the Net Cashflow bars
    Then the user should be able to see a tooltip with the following details:
      | Period       |
      | Net Cashflow |
    When the user hovers over the Budget lines
    Then the user should be able to see a tooltip with the following details:
      | Period |
      | Budget |
    When the user selects any of the Net Cashflow period bars or points in the Net Cashflow period line
    Then the user should see the selected period highlighted and the opacity of unselected bars and lines reduced
    And the values should be updated in the Net Cashflow table as per the selected period bar/line
    And the visuals should be updated in the Net Cashflow Variance scatter chart as per the selected period bar/line
    When the user hovers over any point in the scatter chart
    Then the user should be able to see a tooltip with the following details:
      | Entity Name |
      | Variance    |
      | Variance %  |
    When the user clicks on the selected Net Cashflow period bar/line or anywhere in the Net Cashflow line stacked column combo chart
    Then the user should see the selection reverted
    And the values and visuals of the Net Cashflow table and Net Cashflow Variance scatter chart also reverted
    When the user clicks the Focus Mode icon from the Net Cashflow line stacked column combo chart
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page
    When the user hovers over the Filters icon in the Net Cashflow line stacked column combo chart
    Then the user should see the applied filters