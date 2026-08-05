Feature: Financial Portfolio Hub

  Scenario: Verify interactions with the Revenue line stacked column combo chart
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    And User clicks More Details from Revenues keycard
    Then x and y axis should aligned properly
      | Axes  | Name    |
      | x     | Period  |
      | y     | Revenue |
    And Period should not start with (blank)
    And User sees the legends in the Revenue line stacked column combo chart for:
      | Revenue |
      | Budget  |
    And User should be able to see the bars in the chart as per the amount range
    When User hovers over the Revenue bars
    Then User should be able to see tooltip with the following details:
      | Period  |
      | Revenue |
    When User hovers over the Budget lines
    Then User should be able to see tooltip with the following details:
      | Period |
      | Budget |
    When User selects any of the Revenue period bar or point in Revenue period line
    Then User should see the selected period highlighted and opacity of unselected bars and line is reduced
    And the values should be updated in the Revenue table as per the selected period bar/line
    And the visuals should be updated in the Revenue Variance scatter chart as per the selected period bar/line
    When User hovers over any point in the scatter chart
    Then User should be able to see tooltip with the following details:
      | Entity                       |
      | Revenue Variance To Budget   |
      | Revenue Variance To Budget % |
    When User clicks on the selected Revenue period bar/line or anywhere in the Revenue line stacked column combo chart
    Then User should see the selection is reverted
    And the values and visuals of Revenue table and Revenue variance scatter chart are also reverted
    When User clicks Focus Mode icon from the Revenue line stacked column combo chart
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page
    When User hovers over the Filters icon in the Revenue line stacked column combo chart
    Then User should see the applied filters