Feature: Net Cashflow Variance Scatter Chart in Financial Portfolio Hub

  Scenario: User interacts with the Net Cashflow visuals and updates based on selection
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    And User opens More Details from Net Cashflow keycard
    Then User sees the legends in the Net Cashflow line stacked column combo chart for:
      | Net Cashflow |
      | Budget       |
    Then User should be able to see the bars in the chart as per the amount range

    When User hovers over the Net Cashflow bars
    Then User should be able to see tooltip with the following details:
      | Period       |
      | Net Cashflow |

    When User hovers over the Budget lines
    Then User should be able to see tooltip with the following details:
      | Period |
      | Budget |

    When User selects any of the Net Cashflow period bar or point in Net Cashflow period line
    Then User should see the selected period highlighted and opacity of unselected bars and lines is reduced
    And the values should be updated in the Net Cashflow table as per the selected period bar/line
    And the visuals should be updated in the Net Cashflow Variance scatter chart as per the selected period bar/line

    When User hovers over any point in the scatter chart
    Then User should be able to see tooltip with the following details:
      | Entity                            |
      | Net Cashflow Variance To Budget   |
      | Net Cashflow Variance To Budget % |

    When User clicks on the selected Net Cashflow period bar/line or anywhere in the Net Cashflow line stacked column combo chart
    Then User should see the selection is reverted
    And the values and visuals of Net Cashflow table and Net Cashflow variance scatter chart are also reverted

    When User clicks Focus Mode icon from the Net Cashflow line stacked column combo chart
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page

    When User hovers over the Filters icon in the Net Cashflow line stacked column combo chart
    Then User should see the applied filters