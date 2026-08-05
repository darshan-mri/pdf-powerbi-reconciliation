Feature: Financial Portfolio Hub

  Scenario: User interacts with the Operating Expenses line stacked column combo chart and associated visuals
    Given User logs into Power BI
    When User opens Financial Portfolio Hub report from the workspace
    And User opens More Details from Operating Expenses keycard
    Then User sees the legends in the Operating Expenses line stacked column combo chart for:
      | Operating Expenses |
      | Budget             |
    Then User should be able to see the bars in the chart as per the amount range
    When User hovers over the Operating Expenses bars
    Then User should be able to see a tooltip with the following details:
      | Period             |
      | Operating Expenses |
    When User hovers over the Budget lines
    Then User should be able to see a tooltip with the following details:
      | Period |
      | Budget |
    When User selects any of the Operating Expenses period bar or point in Operating Expenses period line
    Then User should see the selected period highlighted and opacity of unselected bars and line is reduced
    And the values should be updated in the Operating Expenses table as per the selected period bar/line
    And the visuals should be updated in the Operating Expenses Variance scatter chart as per the selected period bar/line
    When User hovers over any point in the scatter chart
    Then User should be able to see a tooltip with the following details:
      | Entity |
      | Operating Expenses Variance To Budget   |
      | Operating Expenses Variance To Budget % |
    When User clicks on the selected Operating Expenses period bar/line or anywhere in the Operating Expenses line stacked column combo chart
    Then User should see the selection is reverted
    And the values and visuals of Operating Expenses table and Operating Expenses variance scatter chart should also be reverted
    When User clicks Focus Mode icon from the Operating Expenses line stacked column combo chart
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page
    When User hovers over the Filters icon in the Operating Expenses line stacked column combo chart
    Then User should see the applied filters