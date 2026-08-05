Feature: Debt Service Interactions in Financial Portfolio Hub

  Scenario: User interacts with the Debt Service line stacked column combo chart and visuals update accordingly
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    And User opens More Details from Debt Service keycard
    Then User sees the legends in the Debt Service line stacked column combo chart for:
      | Debt Service |
      | Budget       |
    Then User should be able to see the bars in the chart as per the amount range

    When User hovers over the Debt Service bars
    Then User should be able to see tooltip with the following details:
      | Period       |
      | Debt Service |

    When User hovers over the Budget lines
    Then User should be able to see tooltip with the following details:
      | Period |
      | Budget |

    When User selects any of the Debt Service period bar or point in Debt Service period line
    Then User should see the selected period highlighted and opacity of unselected bars and line is reduced
    And the values should be updated in the Debt Service table as per the selected period bar/line
    And the visuals should be updated in the Debt Service Variance scatter chart as per the selected period bar/line

    When User hovers over any point in the scatter chart
    Then User should be able to see tooltip with the following details:
      | Entity                            |
      | Debt Service Variance To Budget   |
      | Debt Service Variance To Budget % |

    When User clicks on the selected Debt Service period bar/line or anywhere in the Debt Service line stacked column combo chart
    Then User should see the selection is reverted
    And the values and visuals of Debt Service table and Debt Service variance scatter chart is also reverted

    When User clicks Focus Mode icon from the Debt Service line stacked column combo chart
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page

    When User hovers over the Filters icon in the Debt Service line stacked column combo chart
    Then User should see the applied filters