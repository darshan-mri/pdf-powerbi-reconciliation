Feature: Net Cashflow Variance Scatter Chart Interactions in Financial Portfolio Hub

  Scenario: User interacts with the Net Cashflow variance scatter chart and visuals update accordingly
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    And User opens More Details from Net Cashflow keycard
    Then User sees the Net Cashflow variance scatter chart on scrolling down
    And User should see the Entities in the top of the chart
    And User should see Net Cashflow Variance to Budget range slider in the X-axis and Net Cashflow Variance to Budget % range slider in the Y-axis

    When User moves any of the sliders
    Then the values/visuals in the scatter chart should be as per the selected range

    When User hovers over any of the points in the scatter chart
    Then User should see tooltip with the following details:
      | Entity                            |
      | Net Cashflow Variance to Budget   |
      | Net Cashflow Variance to Budget % |

    When User selects any of the points in the scatter chart
    Then User should see the opacity of the unselected points reduced
    And the visuals and values of Net Cashflow line stacked column combo chart and Net Cashflow table should be updated as per the selected point

    When User hovers over selected or any unselected points in the scatter chart
    Then User should see tooltip with the following details:
      | Entity                            |
      | Net Cashflow Variance to Budget   |
      | Net Cashflow Variance to Budget % |

    When User hovers over the bar of Net Cashflow line stacked column combo chart
    Then User sees tooltip with the following details:
      | Period       |
      | Net Cashflow |
      | Highlighted  |

    When User hovers over the line of Net Cashflow line stacked column combo chart
    Then User sees tooltip with the following details:
      | Period |
      | Budget |
    And the tooltip values should match the selected point in the Net Cashflow variance scatter chart

    When User clicks Focus Mode icon from the Net Cashflow variance scatter chart
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page

    When User hovers over the Filters icon in the Net Cashflow variance scatter chart
    Then User should see the applied filters

    When User selects the already selected point in the scatter chart or clicks anywhere in the scatter chart
    Then the visuals and values should be reverted in the Net Cashflow variance scatter chart, Net Cashflow table, and Net Cashflow line stacked column combo chart

    When User applies any single or combination of filters from the filters pane
    Then the visuals and values should be updated as per the filters applied