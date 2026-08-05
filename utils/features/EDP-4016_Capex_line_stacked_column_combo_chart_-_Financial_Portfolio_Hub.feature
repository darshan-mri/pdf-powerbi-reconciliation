Feature: Financial Portfolio Hub

  Scenario: User interacts with the Capex line stacked column combo chart and associated visuals
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    And User opens More Details from Capex keycard
    Then User sees the legends in the Capex line stacked column combo chart for:
      | Capex Expenses |
      | Budget         |
    Then User should be able to see the bars in the chart as per the amount range
    When User hovers over the Capex bars
    Then User should be able to see tooltip with the following details:
      | Period |
      | Capex  |
    When User hovers over the Budget lines
    Then User should be able to see tooltip with the following details:
      | Period |
      | Budget |
    When User selects any of the Capex period bar or point in Capex period line
    Then User should see the selected period highlighted and opacity of unselected bars and lines is reduced
    And the values should be updated in the Capex table as per the selected period bar/line
    And the visuals should be updated in the Capex Variance scatter chart as per the selected period bar/line
    When User hovers over any point in the scatter chart
    Then User should be able to see tooltip with the following details:
      | Entity                     |
      | Capex Variance To Budget   |
      | Capex Variance To Budget % |
    When User clicks on the selected Capex period bar/line or anywhere in the Capex line stacked column combo chart
    Then User should see the selection is reverted
    And the values and visuals of Capex table and Capex variance scatter chart are also reverted
    When User clicks Focus Mode icon from the Capex line stacked column combo chart
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page
    When User hovers over the Filters icon in the Capex line stacked column combo chart
    Then User should see the applied filter