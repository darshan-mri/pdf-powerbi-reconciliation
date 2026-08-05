Feature: Non-OpEx Line Stacked Column Combo Chart Interactions in Financial Portfolio Hub

  Scenario: User interacts with the Non-OpEx line stacked column combo chart and updates visuals accordingly
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    And User opens More Details from Non-OpEx keycard
    Then User sees the legends in the Non-OpEx line stacked column combo chart for
      | Non-OpEx |
      | Budget   |
    Then User should be able to see the bars in the chart as per the amount range

    When User hovers over the Non-OpEx bars
    Then User should be able to see tooltip with the following details:
      | Period   |
      | Non-OpEx |

    When User hovers over the Budget lines
    Then User should be able to see tooltip with the following details:
      | Period |
      | Budget |

    When User selects any of the Non-OpEx period bar or point in Non-OpEx period line
    Then User should see the selected period highlighted and opacity of unselected bars and line is reduced
    And the values should be updated in the Non-OpEx table as per the selected period bar/line
    And the visuals should be updated in the Non-OpEx Variance scatter chart as per the selected period bar/line

    When User hovers over any point in the scatter chart
    Then User should be able to see tooltip with the following details:
      | Entity                        |
      | Non-OpEx Variance To Budget   |
      | Non-OpEx Variance To Budget % |

    When User clicks on the selected Non-OpEx period bar/line or anywhere in the Non-OpEx line stacked column combo chart
    Then User should see the selection is reverted
    And the values and visuals of Non-OpEx table and Non-OpEx variance scatter chart are also reverted

    When User clicks Focus Mode icon from the Non-OpEx line stacked column combo chart
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page

    When User hovers over the Filters icon in the Non-OpEx line stacked column combo chart
    Then User should see the applied filters