Feature: B&F Financial Portfolio Hub

  Scenario: Verify Revenue keycard and related visuals interactions
    Given the user logs into Power BI
    When the user opens the Financial Portfolio Hub report from the workspace
    And the user clicks on the Revenues keycard
    Then the user sees the Revenue line stacked column combo chart with the following legends:
      | Revenue |
      | Budget  |
    Then the user should be able to see the bars in the chart as per the amount range
    When the user hovers over the Revenue bars
    Then the user should be able to see a tooltip with the following details:
      | Period  |
      | Revenue |
    When the user hovers over the Budget lines
    Then the user should be able to see a tooltip with the following details:
      | Period |
      | Budget |
    When the user selects any of the Revenue period bars or points in the Revenue period line
    Then the user should see the selected period highlighted and the opacity of unselected bars and lines reduced
    And the values should be updated in the Revenue table as per the selected period bar/line
    And the visuals should be updated in the Revenue Variance scatter chart as per the selected period bar/line
    When the user hovers over any point in the scatter chart
    Then the user should be able to see a tooltip with the following details:
      | Entity name                        |
      | B&F Revenue Variance To Variance   |
      | B&F Revenue Variance To Variance % |
    When the user clicks on the selected Revenue period bar/line or anywhere in the Revenue line stacked column combo chart
    Then the user should see the selection reverted
    And the values and visuals of the Revenue table and Revenue Variance scatter chart also reverted
    When the user clicks the Focus Mode icon from the Revenue line stacked column combo chart
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page
    When the user hovers over the Filters icon in the Revenue line stacked column combo chart
    Then the user should see the applied filters