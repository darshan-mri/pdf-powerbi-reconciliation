Feature: Financial Portfolio Hub

  Scenario: User interacts with the NOI line stacked column combo chart and associated visuals
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    And User opens More Details from NOI keycard
    Then User sees the legends in the NOI line stacked column combo chart for
      | NOI    |
      | Budget |
    Then User should be able to see the bars in the chart as per the amount range
    When User hovers over the NOI bars
    Then User should be able to see tooltip with the following details:
      | Period |
      | NOI    |
    When User hovers over the Budget lines
    Then User should be able to see tooltip with the following details:
      | Period |
      | Budget |
    When User selects any of the NOI period bar or point in NOI period line
    Then User should see the selected period highlighted and opacity of unselected bars and lines is reduced
    And the values should be updated in the NOI table as per the selected period bar/line
    And the visuals should be updated in the NOI Variance scatter chart as per the selected period bar/line
    When User hovers over any point in the scatter chart
    Then User should be able to see tooltip with the following details:
      | Entity                   |
      | NOI Variance To Budget   |
      | NOI Variance To Budget % |
    When User clicks on the selected NOI period bar/line or anywhere in the NOI line stacked column combo chart
    Then User should see the selection is reverted
    And the values and visuals of NOI table and NOI variance scatter chart are also reverted
    When User clicks Focus Mode icon from the NOI line stacked column combo chart
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page
    When User hovers over the Filters icon in the NOI line stacked column combo chart
    Then User should see the applied filters